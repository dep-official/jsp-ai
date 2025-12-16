package com.core.event.mapper;

import com.core.event.entity.Event;
import com.core.event.entity.EventNotice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EventMapper {
    //event 조회 
    Event getEventById(@Param("id") Long id);

    // EventNotice 목록 조회
    List<EventNotice> getEventNoticeById(@Param("id") Long id);

}

