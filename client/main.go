package main

import (
	"log/slog"
	"net/http"
)

func main() {
	u := "http://finedog.lan/switch/trigger_the_dog/turn_on"
	slog.Info("Triggering the dog", "url", u)
	req, err := http.NewRequest(http.MethodPost, u, nil)
	if err != nil {
		slog.Error("Error triggering the dog", "error", err)
		return
	}
	_, err = http.DefaultClient.Do(req)
	if err != nil {
		slog.Error("Error sending request to trigger the dog", "error", err)
		return
	}
	slog.Info("Successfully triggered the dog", "url", u)
}
