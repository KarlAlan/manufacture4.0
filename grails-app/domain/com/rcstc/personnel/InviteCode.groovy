package com.rcstc.personnel

class InviteCode {

    static constraints = {
        inviter nullable: false
        inviteCode nullable: false
        inviteDate nullable: false
        inviteeEmail nullable: false
        invitee nullable: true
        project nullable: true
        role nullable: true
        auth nullable: true
    }

    String inviter
    Date inviteDate
    String invitee
    String inviteeEmail
    String inviteCode
    String project
    String role
    String auth

    static InviteCode generateCode(String inviter, String invitee, String inviteeEmail, String aut){
        removeAllExpired()

        def instance = new InviteCode()
        instance.inviter = inviter
        instance.inviteDate = new Date()
        instance.invitee = invitee
        instance.inviteeEmail = inviteeEmail
        instance.inviteCode = randomCode()
        if(aut){
            instance.auth = aut
        }
        instance.save flush: true, insert: true

        instance
    }

    private static String randomCode(){
        def n = new Random().nextInt(1000001).toString()

        while (InviteCode.countByInviteCode(n)>0){
            n = new Random().nextInt(1000001).toString()
        }
        return n
    }

    private static void removeAllExpired(){
        InviteCode.where {
            inviteDate < new Date() - 7
        }.deleteAll()

        InviteCode.withSession { it.flush() }
    }
}
