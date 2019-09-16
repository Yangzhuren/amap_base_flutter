package me.yohom.amapbase.model

import com.amap.api.maps.model.LatLng
import com.amap.api.services.district.DistrictItem

class District(
        var item: DistrictItem,
        var latLngs: List<LatLng>?
)