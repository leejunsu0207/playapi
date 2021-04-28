package com.example.playapi.controller;

import com.example.playapi.service.LottoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/lotto")
public class LottoController {

    private final LottoService lottoService;

    public LottoController(LottoService lottoService) {
        this.lottoService = lottoService;
    }


    @RequestMapping
    public String lottoPage() {
        return "lotto";
    }

    @ResponseBody
    @RequestMapping("/randomNumber")
    public List<String> lottoRandomNumber(@RequestParam Map<String, Object> pMap) throws Exception {
        System.out.println("lottoRandomNumber:::::::");
        List<String> temp = lottoService.getLottoRandomNumber((String)pMap.get("gameCount"));

        return temp;
    }

    @ResponseBody
    @RequestMapping("/randomNumbers")
    public int[][] lottoRandomNumbers(@RequestParam Map<String, Object> pMap) throws Exception {
        System.out.println("lottoRandomNumber:::::::");
        int[][] temp = lottoService.getLottoRandomNumbers((String)pMap.get("gameCount"));

        return temp;
    }
}
