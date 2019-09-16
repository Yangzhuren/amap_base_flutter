package me.yohom.amapbase.common

import com.amap.api.maps.model.LatLng
import com.amap.api.services.district.DistrictItem

object Utils {
    fun parseData(districtItem: DistrictItem): List<LatLng>? {
        val polyStr = districtItem.districtBoundary()
        if (polyStr == null || polyStr.isEmpty()) {
            return null
        }

        val list = ArrayList<LatLng>()
        for (str in polyStr) {
            val lat = str.split(";".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            var isFirst = true
            var firstLatLng: LatLng? = null
            for (latstr in lat) {
                val lats = latstr.split(",".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                if (isFirst) {
                    isFirst = false
                    firstLatLng = LatLng(java.lang.Double
                            .parseDouble(lats[1]), java.lang.Double
                            .parseDouble(lats[0]))
                }
                list.add(LatLng(java.lang.Double
                        .parseDouble(lats[1]), java.lang.Double
                        .parseDouble(lats[0])))
            }
            if (firstLatLng != null) {
                list.add(firstLatLng)
            }
        }
        return list
    }
}