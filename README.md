#HybridDemo
通过使用WebViewJavascriptBridge来实现oc与js交互的一个例子,原理是通过url的拦截.

#具体用法
在webView中需要初始化一些信息

	        /*这段代码是固定的，必须要放到js中*/
        function setupWebViewJavascriptBridge(callback) {
            if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
            if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
            window.WVJBCallbacks = [callback];
            var WVJBIframe = document.createElement('iframe');
            WVJBIframe.style.display = 'none';
            WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
            document.documentElement.appendChild(WVJBIframe);
            setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
        }


先初始化通信桥,然后注册Handler,在:

    [WebViewJavascriptBridge enableLogging];
	self.bridge = [WebViewJavascriptBridge 	 bridgeForWebView:self.testView];
	[self.bridge setWebViewDelegate:self];
    //注册
    [self.bridge registerHandler:@"jsLetOcDo" handler:^(id data, WVJBResponseCallback responseCallback) {
        //从js获取数据
        NSLog(@"js call oc do something,data from js is %@",data);
        if (responseCallback) {
            //反馈给JS
            responseCallback(@{@"testId":@"111111"});
        }
    }];
    //调用
	bridge.callHandler('jsLetOcDo', {'blogURL': 'Hi,there is OC '}, function(response) {

	//do something
                                     })
          }
	})

然后在js中调用:
	
	 bridge.callHandler('jsLetOcDo', {'blogURL': 'Hi,there is OC '}, function(response) {
                                                        // log('JS got response', response)
                                                        })
                                     	}
                                     })
                                     
#OC调用JS
原理基本相同，都是先注册handler，再callhander
#关于Android
目前有android版本的，并且写法几乎相同                                     
