
CACHE_VERSION = "v1"

self.addEventListener "install", (event) ->
    event.waitUntil(
        self.caches.open CACHE_VERSION
        .then (cache) ->
            cache.addAll [
                "./css/semantic.min.css"
                "./css/index.css"
                "./img/app-icon.png"
                "./js/vue.min.js"
                "./js/semantic-ui-vue.min.js"
                "./js/index.js"
                "./"
            ]
    )

self.addEventListener "fetch", (event) ->
    event.respondWith(
        self.caches.open CACHE_VERSION
        .then (cache) ->
            cache.match event.request
        .then (response) ->
            response or self.fetch(event.request)
    )
