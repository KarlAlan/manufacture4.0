package com.rcstc.acl

class Role {

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}

    // 客户权限
    final static def SUPERVISOR = "SUPERVISOR"
    final static def USER = "USER"
    final static def ADMIN = "ADMIN"
    final static def SUPER_ADMIN = "SUPER_ADMIN"
    final static def SALESMAN = "SALESMAN"
    final static def FINANCE = "FINANCE"
    final static def BUSINESS = "BUSINESS"
}
