/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.xmlrpc

/**
 * Created by Irene on 2016-01-22.
 */
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//
import groovy.net.xmlrpc.RPCServerProxy
import groovy.net.xmlrpc.XMLRPCCallFailureException
import groovy.net.xmlrpc.XMLRPCMessageProcessor
import uk.co.wilson.net.xmlrpc.XMLRPCFailException

public class Utf8XmlRpcServerProxy extends RPCServerProxy {
    static final String xmlDeclaration = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    private URL serverURL;

    public Utf8XmlRpcServerProxy(String serverURL) throws MalformedURLException {
        this.serverURL = new URL(serverURL);
    }

    public Object invokeMethod(String name, Object args) {
        if ("invokeMethod".equals(name)) {
            return super.invokeMethod(name, args);
        } else {
            Object[] params = args instanceof List ? ((List) args).toArray() : (Object[]) ((Object[]) args);
            int numberOfParams = params.length;
            if (numberOfParams != 0 && params[numberOfParams - 1] instanceof Closure) {
                --numberOfParams;
            }

            try {
                byte[] e = XMLRPCMessageProcessor.emitCall(new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"), name, params, numberOfParams).toString().getBytes("ISO-8859-1");
                URLConnection connection = this.serverURL.openConnection();
                connection.setDoInput(true);
                connection.setDoOutput(true);
                connection.setUseCaches(false);
                connection.setAllowUserInteraction(false);
                connection.setRequestProperty("Content-Length", Integer.toString(e.length));
                connection.setRequestProperty("Content-Type", "text/xml");
                OutputStream requestStream = connection.getOutputStream();
                requestStream.write(e);
                requestStream.flush();
                requestStream.close();
                XMLRPCMessageProcessor responseParser = new XMLRPCMessageProcessor();

                try {
                    responseParser.parseMessage(connection.getInputStream());
                } catch (XMLRPCFailException var11) {
                    throw new XMLRPCCallFailureException(var11.getFaultString(), new Integer(var11.getFaultCode()));
                }

                List response = responseParser.getParams();
                if (response == null) {
                    throw new XMLRPCCallFailureException("Empty response from server", new Integer(0));
                } else if (numberOfParams == params.length) {
                    return response.get(0);
                } else {
                    Closure closure = (Closure) params[numberOfParams];
                    closure.setDelegate(this);
                    return closure.call([response.get(0)]);
                }
            } catch (IOException var12) {
                throw new XMLRPCCallFailureException(var12.getMessage(), new Integer(0));
            } catch (XMLRPCFailException var13) {
                throw new XMLRPCCallFailureException(var13.getFaultString(), var13.getCause());
            }
        }
    }
}

