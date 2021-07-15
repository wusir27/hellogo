package main

import (
	"github.com/wusir27/hellogo/pkg/tcp"
	"log"
	"os"
	"os/signal"
	"sync"
	"syscall"
)

func main() {
	tcp.EpollBootstrape()
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	sig := <-sigChan
	go func() {
		sig := <-sigChan
		log.Printf("%v signal received, closing  immediately", sig)
		os.Exit(255)
	}()
	log.Printf("%v signal received, closing tcpserver", sig)

	wg := &sync.WaitGroup{}
	wg.Add(1)

	tcp.Shutdown(wg)
	wg.Wait()
}
