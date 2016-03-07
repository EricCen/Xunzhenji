class UrlMappings {

	static mappings = {
		"/$upload/$action/$type/$year/$month/$id"(controller: "upload")

		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		group "/wap", {
			"/show/$controller?/$id?"(action: 'wap_show')
			"/list/$controller?/$id?"(action: 'wap_list')
		}

		"/"(controller: "home", action: "index")
		"500"(view:'/error')
	}
}
