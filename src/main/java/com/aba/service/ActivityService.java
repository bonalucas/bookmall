package com.aba.service;

import com.aba.pojo.Activity;
import com.aba.pojo.ActivityExample;

import java.util.List;

public interface ActivityService {
    List<Activity> getAllActivity(ActivityExample activityExample);

    void insertActivitySelective(Activity activity);

    Activity selectByKey(Integer activityid);

    void deleteByActivityId(Integer activityid);
}
