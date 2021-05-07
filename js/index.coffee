
worksInfo = {
	i7: { # 作品を識別する名前
		meta: {
			shortName: "アイナナ" # 作品の短い名前
			longName: "アイドリッシュセブン" # 作品の正式な名前
		}
		characters: {
			"一織": {} # キャラクターの名前
			"大和": {}
			"三月": {}
			"環": {}
			"壮五": {}
			"ナギ": {}
			"陸": {}
			"楽": {}
			"天": {}
			"龍之介": {}
			"百": {}
			"千": {}
		}
	}
}

Vue.use SemanticUIVue

new Vue {
	el: "#app"
	data: -> @load() or {
		work: ""
		goods: ""
		gives: []
		takes: []
		byHand: false
		handAt: ""
		byMail: false
		welcomeFromSearch: false
		worksInfo: worksInfo
	}
	computed: {
		tweetText: ->
			ret = [
				"交換"
				"#{@worksInfo[@work]?.meta.longName} #{@worksInfo[@work]?.meta.shortName}"
				@goods
				""
				"譲　#{@gives.join "、"}"
				"求　#{@takes.join "、"}"
				""
				(=>
					ret = []
					ret.push "郵送" if @byMail
					ret.push "、または" if @byHand and @byMail
					ret.push "#{if @handAt isnt "" then "#{@handAt}での" else ""}手渡し" if @byHand
					ret.push "希望です。"
					ret.join ""
				)()
			]
			ret.push "検索からでもお気軽にお声がけください。" if @welcomeFromSearch
			ret.join "\n"
		workOptions: ->
			Object.keys @worksInfo
				.map (key) => {
					text: @worksInfo[key].meta.longName
					value: key
				}
		isWebView: ->
			window.navigator.standalone or
			window.matchMedia? "(display-mode: standalone)"
				.matches
	}
	watch: {
		handAt: (value) ->
			@byHand = value isnt ""
	}
	methods: {
		load: ->
			JSON.parse localStorage.getItem "oshiwanted"
		save: (event) ->
			localStorage.setItem "oshiwanted", JSON.stringify @$data
	}
}

navigator.serviceWorker.register "./worker.js"
