package com.example.playapi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/covid")
public class CovidController {

    @RequestMapping()
    public String covid(){return "covid";}



}
