package com.hx.cms.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * @Title: InfoITag.java
 * @Description: 循环索引值<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoITag extends TagSupport {
    
    /**
     * 序列化
     */
    private static final long serialVersionUID = 330680087521827763L;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        Tag tag = getParent();
        //输出内容
        int html = 0;
        
        try {
            if(tag instanceof InfoListTag){
                InfoListTag infoListTag = (InfoListTag) tag;
                html = infoListTag.getI();
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
