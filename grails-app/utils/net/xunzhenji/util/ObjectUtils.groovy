package net.xunzhenji.util

import net.xunzhenji.mall.Image

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/18 23:44
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class ObjectUtils {

    def static updateImage(obj, imageId) {
        if (imageId) {
            def ids
            if (imageId instanceof String[]) {
                ids = imageId.collect { it as Long }
            } else {
                ids = [imageId as Long]
            }
            def images = Image.findAllByIdInList(ids)
            obj.images = images
        }
    }

    def static convertList(input){
        def ret = []
        if(input instanceof String){
            if(input.indexOf(",")){
                ret.addAll(Arrays.asList(input.split(",")))
            }else{
                ret << input
            }
        }else if(input instanceof String[]){
            ret.addAll(Arrays.asList(input))
        }
        ret
    }
}
