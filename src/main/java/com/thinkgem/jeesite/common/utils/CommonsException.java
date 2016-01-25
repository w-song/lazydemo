/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */
package com.thinkgem.jeesite.common.utils;

/**
 * CommonsException
 * 
 * @author MingYi
 * @date 2015-6-9
 */
public class CommonsException extends RuntimeException {

    private static final long serialVersionUID = 699978142734398943L;

    public CommonsException() {
        super();
    }

    public CommonsException(String message, Throwable cause) {
        super(message, cause);
    }

    public CommonsException(Throwable cause) {
        super(cause);
    }

    public CommonsException(String message) {
        super(message);
    }
}
