package com.example.playapi.restapi;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URLEncoder;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class LottoRestApi {

    @GetMapping("/lottoNumber")
    public ResponseEntity<Map> getLottoNum(String drwNo) throws Exception {
        Map<String, Object> save;
        StringBuilder urlBuilder = new StringBuilder("https://www.dhlottery.co.kr/common.do");
        urlBuilder.append("?" + URLEncoder.encode("method", "UTF-8") + "=" + URLEncoder.encode("getLottoNumber", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("drwNo", "UTF-8") + "=" + URLEncoder.encode(drwNo, "UTF-8"));

//        String url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="+drwNo;

        UriComponents uriComponents = UriComponentsBuilder
                .fromHttpUrl(String.valueOf(urlBuilder))
                .build();
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        httpHeaders.set(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);

        HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

        ResponseEntity<String> exchange = restTemplate.exchange(uriComponents.toUriString(), HttpMethod.GET, httpEntity, String.class);

        ObjectMapper mapper = new ObjectMapper();
        save = mapper.readValue(exchange.getBody(), new TypeReference<Map<String, Object>>() {
        });

        return ResponseEntity.ok(save);

    }

}
