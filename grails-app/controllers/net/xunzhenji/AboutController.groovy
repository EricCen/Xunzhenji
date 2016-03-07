package net.xunzhenji

import grails.converters.JSON
import net.xunzhenji.mall.Image
import org.apache.commons.lang.time.DateFormatUtils

class AboutController {

    def About aboutPage = About.first()

    def index() {
        [aboutPage: aboutPage]
    }

    def edit() {
        if(aboutPage == null){
            aboutPage = new About(content: "");
            aboutPage.save()
        }
        aboutPage.properties = params
        [aboutPage: aboutPage]
    }

    def save(params) {
        aboutPage = aboutPage.refresh()

        if (params['image.id']) {
            def ids
            if (params['image.id'] instanceof String[]) {
                ids = params['image.id'].collect { it as Long }
            } else {
                ids = [params['image.id'] as Long]
            }

            def images = Image.findAllByIdInList(ids)
            aboutPage.images = images
        }

        aboutPage.properties = params

        aboutPage.validate()
        if (aboutPage.hasErrors()) {
            respond aboutPage.errors, view:'edit', model: [aboutPage: aboutPage]
            return
        }

        aboutPage.save(flush: true)
        aboutPage.images.each { it.ownerClass = aboutPage.class.getName(); it.ownerId = aboutPage.id; it.save() }
        redirect(controller: "about", action: "edit", id: "1")
    }

    def fileManager() {
        def images = aboutPage.images
        def fileList = []
        def currentUrl
        images.each { image ->
            if(!currentUrl) currentUrl=image.host
            def fileName = image.fileName
            def createdDate = new Date(fileName.substring(0, fileName.indexOf('-')) as long)
            fileList << [is_dir  : false, has_file: false, filesize: image.size, dir_path: "",
                         is_photo: true, filetype: 'jpg', filename: image.mobilePath,
                         datetime: DateFormatUtils.format(createdDate, 'yyyy-MM-dd HH:mm:ss')]
        }
        def ret = [current_url: currentUrl + "/", total_count: images.size(), file_list: fileList]
        render(ret as JSON)
    }
}
