 /**
 * @Title: AttPackageAction.java
 * @Package com.dcfs.cms
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author xxx   
 * @project DCFS 
 * @date 2014-10-27 12:26:56
 * @version V1.0   
 */
package com.dcfs.common.atttypemanager;

import java.sql.Connection;
import java.sql.SQLException;
import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.InfoClueTo;

/**
 * @Title: AttPackageAction.java
 * @Description:附件集合管理
 * @Created on 2014-10-27 12:26:56
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class AttPackageAction extends BaseAction{

	private static Log log = UtilLog.getLog(AttPackageAction.class);

    private AttPackageHandler handler;
	
	private Connection conn = null;//数据库连接
	
	private DBTransaction dt = null;//事务处理
	
	private String retValue = SUCCESS;

    public AttPackageAction(){
        this.handler=new AttPackageHandler();
    } 
    
    public String execute() throws Exception {
        return null;
    }

    /**
     * 添加页面跳转(描述可自定义)
	 * @author xxx
	 * @date 2014-10-27 12:26:56
     * @return
     */
    public String add(){
        
        return retValue;
        
    }
    
    /**
     * 保存方法(描述可自定义)
	 * @author xxx
	 * @date 2014-10-27 12:26:56
     * @return
     */
    public String save(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("P_","ID","PACKAGE_NAME","SMALL_TYPE_IDS","BIG_TYPE");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            success=handler.save(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");//保存成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
			retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AttPackageAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }

    /**
     * 查询方法(描述可自定义)
	 * @author xxx
	 * @date 2014-10-27 12:26:56
     * @return
     */
    public String findList(){
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=null;
		}	
        //3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
        Data data = getRequestEntityData("S_","BIG_TYPE");
        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
        } finally {
		    //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AttPackageAction的Connection因出现异常，未能关闭",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }

     /**
     * 查看方法(描述可自定义)
	 * @author wangzheng
	 * @date 2014-10-27 12:26:56
     * @return
     */
    public String show(){
     String uuid = getParameter("UUID");
	 String type = getParameter("type");
        try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            DataList smallTypeList = this.getSmallTypeByBigType(conn, showdata.getString("BIG_TYPE"));
            setAttribute("data", showdata);
            setAttribute("smallTypeList", smallTypeList);
        } catch (DBException e) {
            e.printStackTrace();
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
        if("show".equals(type)){
            return "show";
        }else if("mod".equals(type)){
            return "mod";
        }else {
            return retValue;
        }
    }
  
    /**
     * 删除方法(描述可自定义)
	 * @author xxx
	 * @date 2014-10-27 12:26:56
     * @return
     */
    public String delete(){
        String deleteuuid=getParameter("deleteuuid", "");
        deleteuuid=deleteuuid.substring(1, deleteuuid.length());
        String[] uuid= deleteuuid.split("#");
        try{
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.delete(conn,uuid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("删除操作异常[删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AttPackageAction的Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
            return retValue;
    }
    /**
     * 根据业务大类获得附件小类集合
     * @param conn
     * @param BIG_TYPE
     * @return
     * @throws DBException
     */
    public DataList getSmallTypeByBigType(Connection conn,String BIG_TYPE) throws DBException{
    	return this.handler.getSmallTypeByBigType(conn, BIG_TYPE);
    }
}