package com.rcstc.manufacture

class ManufactureFile {

    static constraints = {
        originalFilename nullable: false
        thumbnailFilename nullable: false
        newFilename nullable: false
        fileSize nullable: true
        fileType nullable: false
        objectType nullable: true
        objectId nullable: true
    }

    String originalFilename
    String thumbnailFilename
    String newFilename
    String fileSize
    String fileType
    String objectType
    String objectId
}
