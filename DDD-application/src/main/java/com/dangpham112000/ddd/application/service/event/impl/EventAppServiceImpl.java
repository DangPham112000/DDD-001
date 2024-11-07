package com.dangpham112000.ddd.application.service.event.impl;

import com.dangpham112000.ddd.application.service.event.EventAppService;
import com.dangpham112000.ddd.domain.service.HiDomainService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventAppServiceImpl implements EventAppService {
    //    Call domain service

    @Resource
    private HiDomainService hiDomainService;

    @Override
    public String sayHi(String who) {
        return hiDomainService.sayHi(who);
    }
}
