package net.xunzhenji

class WeChatSimulatorController {

    def index() {
        log.info("Simulate Wechat redirect url back with a code, redirect uri: ${params.redirect_uri}")
        redirect(uri: request.forwardURI, params: [code: "13242342"])
    }
}
