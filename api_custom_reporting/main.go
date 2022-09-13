package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"time"
)

// Instantiate a new global HTTP Client with a timeout of 30 seconds
var client = &http.Client{Timeout: 30 * time.Second}

// var wg sync.WaitGroup

// Struct to capture information from json containing API information
type APIInfo struct {
	OrgId string `json:"orgId"`
	Token string `json:"token"`
}

type Organization struct {
	DeviceCount int `json:"device_count"`
}

// Struct to store data from API calls for computers
type Computer struct {
	Id        int    `json:"id"`
	Name      string `json:"name"`
	User      string `json:"last_logged_in_user"`
	Ou        string `json:"organizational_unit"`
	OsFamily  string `json:"os_family"`
	OsName    string `json:"os_name"`
	OSVersion string `json:"os_version"`
	Software  []Software
}

type Software struct {
	Id        int    `json:"id"`
	Name      string `json:"display_name"`
	Version   string `json:"version"`
	Installed bool   `json:"installed"`
}

// Function to read from json and capture API information
func ReadAPIInfo() (string, string) {
	// Instantiate APIInfo object to hold the data we are reading
	apiInfo1 := APIInfo{}
	// Read json file
	data, err := ioutil.ReadFile("api_info.json")
	if err != nil {
		log.Fatalln(err)
	}
	// Parse json data and store it in the memory address of apiInfo1
	jsonErr := json.Unmarshal(data, &apiInfo1)
	if jsonErr != nil {
		log.Fatalln(jsonErr)
	}
	// return the orgId and token for use during WebRequest
	return apiInfo1.OrgId, apiInfo1.Token
}

func GetDeviceCount(orgId string, token string) int {
	deviceCount := []Organization{}
	const baseUrl = "https://example.com/api/"
	req, err := http.NewRequest("GET", baseUrl, nil)
	if err != nil {
		log.Fatalln(err)
	}
	req.Header.Set("Authorization", "Bearer "+token)
	// Perform request with the new client
	res, err := client.Do(req)
	if err != nil {
		log.Fatalln(err)
	}
	defer res.Body.Close()
	// return error associated with New Decoder and the array of computer structs
	decodingErr := json.NewDecoder(res.Body).Decode(&deviceCount)
	if decodingErr != nil {
		log.Fatalln(decodingErr)
	}
	return deviceCount[0].DeviceCount
}

func GetComputers(orgId string, token string, deviceCount int) []Computer {
	// Declare variables for use during web request
	const baseUrl = "https://example.com/api/"
	page := 0
	maxPages := deviceCount / 500
	allComputers := []Computer{}
	computers := []Computer{}
	for page < maxPages+1 {
		// Concatenate full URL for the request
		fullUrl := baseUrl + "?o=" + orgId + "&limit=500&page=" + strconv.Itoa(page)
		// Print status message
		fmt.Printf("Making requests to %v\n", fullUrl)
		// Make web request
		req, err := http.NewRequest("GET", fullUrl, nil)
		if err != nil {
			log.Fatalln(err)
		}
		// Insert header containing authorization information (token)
		req.Header.Set("Authorization", "Bearer "+token)
		// Perform request with the new client
		res, err := client.Do(req)
		if err != nil {
			log.Fatalln(err)
		}
		defer res.Body.Close()
		// return error associated with New Decoder and the array of computer structs
		decodingErr := json.NewDecoder(res.Body).Decode(&computers)
		if decodingErr != nil {
			log.Fatalln(decodingErr)
		}
		allComputers = append(allComputers, computers...)
		page += 1
	}
	return allComputers
}

func GetSoftware(orgId string, token string, computer *Computer) {
	// Declare variables for use during web request
	var fullUrl = "https://example.com/api" + strconv.Itoa(computer.Id) + "/packages?o=" + orgId
	page := 0
	deviceSoftware := []Software{}
	software := []Software{}
	for {
		reqLength := WebRequest(token, fullUrl, page, &software)
		deviceSoftware = append(deviceSoftware, software...)
		if reqLength == 0 {
			break
		} else {
			page += 1
		}
	}
	computer.Software = deviceSoftware
}

func WebRequest(token string, url string, page int, arr *[]Software) int {
	fullUrl := url + "&limit=500&page=" + strconv.Itoa(page)
	// Make web request
	req, err := http.NewRequest("GET", fullUrl, nil)
	if err != nil {
		fmt.Println(err)
	}
	// Insert header containing authorization information (token)
	req.Header.Set("Authorization", "Bearer "+token)
	// Perform request with the new client
	res, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
	}
	defer res.Body.Close()
	// return error associated with New Decoder and the array of computer structs
	decodingErr := json.NewDecoder(res.Body).Decode(&arr)
	if decodingErr != nil {
		fmt.Println(decodingErr)
	}
	return len(*arr)
}

func WriteToJson(computers []Computer) {
	file, _ := json.MarshalIndent(computers, "", " ")
	_ = ioutil.WriteFile("C:\\Temp\\report.json", file, 0644)
}

func main() {
	orgId, token := ReadAPIInfo()
	deviceCount := GetDeviceCount(orgId, token)
	computers := GetComputers(orgId, token, deviceCount)
	for i := 0; i < len(computers); i++ {
		fmt.Printf("Retrieving packages from %v\n", computers[i].Name)
		GetSoftware(orgId, token, &computers[i])
		fmt.Printf("%v out of %v\n", i+1, len(computers)+1)
	}
	WriteToJson(computers)
}
