package com.rcstc.manufacture

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.imgscalr.Scalr
import org.springframework.http.HttpStatus
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

@Secured(["hasRole('USER')"])
class FileController {

    def springSecurityService

    private record(String objectType, String objectId,String operate){
        def operation = new OperateRecord()
        operation.operation = operate
        operation.project = ""
        operation.recordClass = objectType
        operation.person = springSecurityService.currentUser
        operation.username = springSecurityService.currentUser.username
        if(objectId){
            operation.recordId = Long.valueOf(objectId)
        } else {
            operation.recordId = 0L
        }

        operation.description = operate
        operation.operateDate = new Date()
        if (!operation.save(flush: true)) {
            operation.errors.each {
                println it
            }
            return
        }
    }

    @Transactional
    def upload() {
        switch (request.method){
            case "GET":
                def results = []
                ManufactureFile.findAllByObjectTypeAndObjectId(params.objectType,params.objectId).each { ManufactureFile mfile ->
                    results << [
                            name: mfile.originalFilename,
                            size: mfile.fileSize,
                            url: createLink(controller:'file', action:'manufactureFile', id: mfile.id),
                            thumbnail_url: createLink(controller:'file', action:'thumbnail', id: mfile.id),
                            delete_url: createLink(controller:'file', action:'delete', id: mfile.id),
                            delete_type: "DELETE"
                    ]
                }

                render results as JSON
                break;
            case "POST":
                def results = []
                if (request instanceof MultipartHttpServletRequest) {
                    for (filename in request.getFileNames()){
                        MultipartFile file = request.getFile(filename)

                        String newFilenameBase = UUID.randomUUID().toString()
                        String originalFileExtension = file.originalFilename.substring(file.originalFilename.lastIndexOf("."))
                        String newFilename = newFilenameBase + originalFileExtension
                        String storageDirectory = grailsApplication.config.file.upload.directory?:'/tmp'

                        File newFile = new File("$storageDirectory/$newFilename")
                        file.transferTo(newFile)

                        String thumbnailFilename = "havn't thumbnail"
                        if(originalFileExtension.substring(1).toUpperCase().equals("PNG")||originalFileExtension.substring(1).toUpperCase().equals("JPG")||originalFileExtension.substring(1).toUpperCase().equals("JPEG")){
                            BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 50);
                            thumbnailFilename = newFilenameBase + '-thumbnail.png'
                            File thumbnailFile = new File("$storageDirectory/$thumbnailFilename")
                            ImageIO.write(thumbnail, 'png', thumbnailFile)
                        }


                        ManufactureFile mfile = new ManufactureFile(
                                originalFilename: file.originalFilename,
                                thumbnailFilename: thumbnailFilename,
                                newFilename: newFilename,
                                fileSize: file.size,
                                fileType: getFileType(originalFileExtension.substring(1)),
                                objectType: params.objectType,
                                objectId: params.objectId
                        ).save()

                        results << [
                                id: mfile.id,
                                name: mfile.originalFilename,
                                size: mfile.fileSize,
                                url: createLink(controller:'file', action:'manufactureFile', id: mfile.id),
                                thumbnail_url: createLink(controller:'file', action:'thumbnail', id: mfile.id),
                                delete_url: createLink(controller:'file', action:'delete', id: mfile.id),
                                delete_type: "DELETE"
                        ]

                        record(params.objectType, params.objectId ,"上传文件")
                    }
                }

                render results as JSON
                break;
            default: render status: HttpStatus.METHOD_NOT_ALLOWED.value()
        }
    }

    private getFileType(String fileExtension){
        if (fileExtension.toUpperCase().equals("DOC")||fileExtension.toUpperCase().equals("DOCX")){
            return "application/msword"
        }
        if (fileExtension.toUpperCase().equals("XLS")){
            return "application/vnd.ms-excel"
        }
        if (fileExtension.toUpperCase().equals("XLSX")){
            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        }
        if (fileExtension.toUpperCase().equals("TXT")){
            return "text/plain"
        }
        if (fileExtension.toUpperCase().equals("PNG")){
            return "image/png"
        }
        if (fileExtension.toUpperCase().equals("JPG")||fileExtension.toUpperCase().equals("JPEG")){
            return "image/jpeg"
        }
        if (fileExtension.toUpperCase().equals("PDF")){
            return "application/pdf"
        }
        if (fileExtension.toUpperCase().equals("ZIP")){
            return "application/zip"
        }
        return "application/octet-stream"
    }

    @Transactional
    def delete(){
        def mfile = ManufactureFile.get(params.id)
        File manuFile = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${mfile.newFilename}")
        manuFile.delete()
        if(mfile.fileType.equals("image/png")||mfile.fileType.equals("image/jpeg")){
            File thumbnailFile = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${mfile.thumbnailFilename}")
            thumbnailFile.delete()
        }

        mfile.delete()

        record(mfile.objectType, mfile.objectId ,"删除文件")

        def result = [success: true]
        render result as JSON
    }

    def manufactureFile(){
        def mfile = ManufactureFile.get(params.id)
        File manuFile = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${mfile.newFilename}")
        response.contentType = mfile.fileType
        response.outputStream << new FileInputStream(manuFile)
        response.outputStream.flush()
    }

    def thumbnail(){
        def mfile = ManufactureFile.get(params.id)
        File manuFile = null;
        if(mfile.fileType.equals("image/png")||mfile.fileType.equals("image/jpeg")){
            manuFile = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${mfile.thumbnailFilename}")
        }
        else if(mfile.fileType.equals("application/msword")) {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/word50.png"))
        }
        else if(mfile.fileType.equals("application/vnd.ms-excel")||mfile.fileType.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")) {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/excel50.png"))
        }
        else if(mfile.fileType.equals("text/plain")) {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/txt50.png"))
        }
        else if(mfile.fileType.equals("application/pdf")) {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/pdf50.png"))
        }
        else if(mfile.fileType.equals("application/zip")) {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/zip50.png"))
        }
        else {
            manuFile = new File(request.getSession().getServletContext().getRealPath("/images/file50.png"))
        }

        response.contentType = 'image/png'
        response.outputStream << new FileInputStream(manuFile)
        response.outputStream.flush()
    }

}
