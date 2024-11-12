package com.dangpham112000.ddd.controller.resource;

import com.dangpham112000.ddd.application.service.event.EventAppService;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.github.resilience4j.ratelimiter.annotation.RateLimiter;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.security.SecureRandom;

@RestController
@RequestMapping("/hello")
public class HiController {

    @Autowired
    private EventAppService eventAppService;

    @Autowired
    private RestTemplate restTemplate;

    @GetMapping("/hi")
    @RateLimiter(name = "backendA", fallbackMethod = "fallbackHello")
    public String hello() {
        return eventAppService.sayHi("dangne");
    }

    public String fallbackHello(Throwable throwable) {
        return "Too many requests";
    }

    @GetMapping("/hihi")
    @RateLimiter(name = "backendB", fallbackMethod = "fallbackHello")
    public String helloHihi() {
        return eventAppService.sayHi("dangne2");
    }

    private static final SecureRandom secureRandom = new SecureRandom();

    @GetMapping("/circuit/breaker")
    @CircuitBreaker(name = "checkRandom", fallbackMethod = "fallbackCircuitBreaker")
    public String circuitBreaker() {
        int productId = secureRandom.nextInt(19) + 1;
        String url = "https://fakestoreapi.com/products/" + productId;
        return restTemplate.getForObject(url, String.class);
    }

    public String fallbackCircuitBreaker(Throwable throwable) {
        return "Circuit breaker failed";
    }
}
