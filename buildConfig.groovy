environments {
	test {
		server {
			hostname = ''
			port = 8080
			context = 'm4'
			username = ''
			password = ''
		}
	}
	
	uat {
		server {
			hostname = ''
			port = 8080
			context = 'm4'
			username = ''
			password = ''
		}
	}
	
	prod {
		server {
			hostname = 'rqs.transgd.com.cn'
			port = 18080
			context = 'm4'
			username = 'tomcat'
			password = 'needapptomcat'
		}
	}
}