<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>客户管理</title>   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- 导入easyui的资源文件 -->
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
  </head>
  
  <body>
  	<table id="list"></table>
  	
  	<!-- 工具条 -->
  	<div id="tb">
		<a id="addBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a id="editBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a id="deleteBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
	</div>
	
	<!-- 编辑窗口 -->
	<div id="win" class="easyui-window" title="客户数据编辑" style="width:500px;height:300px"   
        data-options="iconCls:'icon-save',modal:true,closed:true">   
	    <form id="editForm" method="post">
	    	<%--提供id隐藏域 --%>
	    	<input type="hidden" name="id">
		  	客户姓名：<input type="text" name="name" class="easyui-validatebox" data-options="required:true"/><br/>
		  	客户性别：
		  	<input type="radio" name="gender" value="男"/>男
		  	<input type="radio" name="gender" value="女"/>女
		  	<br/>
		  	客户手机：<input type="text" name="telephone" class="easyui-validatebox" data-options="required:true"/><br/>
		  	客户住址：<input type="text" name="address" class="easyui-validatebox" data-options="required:true"/><br/>
	  	<a id="saveBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
 	 </form> 
	</div>  
  
  	<script type="text/javascript">
  		$(function() {
			$("#list").datagrid({
				//url:后台数据查询的地址
				url: "customer/listByPage",
				//columns：填充的列数据
				//field:后台对象的属性
				//tille:列标题
				columns: [[
					{
						field: "id",
						title: "客户编号",
						width: 100,
						checkbox: true
					},
					{
						field: "name",
						title: "客户姓名",
						width: 200
					},
					{
						field: "gender",
						title: "客户性别",
						width: 200
					},
					{
						field: "telephone",
						title: "客户手机",
						width: 200
					},
					{
						field: "address",
						title: "客户住址",
						width: 200
					}
				]],
				//显示分页
				pagination: true,
				//工具条
				toolbar: "#tb"
			});
			//打开编辑窗口
			$("#addBtn").click(function(){
				//清空表单数据
				$("#editForm").form("clear");
				$("#win").window("open");
			});
			$("#saveBtn").click(function(){
				console.log(1)
				$("#editForm").form("submit",{
					//表单提交地址
					url:"customer/save",
					dataType:"json",
					//表单提交前的回调函数
					onSubmit:function () {
						//验证表单验证是否通过
						return $("#editForm").form("validate")
					},
					success:function (data) {
						data = eval("("+data+")")
						if(data.success){
							//刷新datagrid
							$("#list").datagrid("reload");
							$.messager.alert("提示","保存成功","info")
						}else{
							$.messager.alert("提示","保存失败"+data.msg,"error")
						}
					}
				})
			})
			$("#editBtn").click(function(){
				//判断只能选择一行
				var rows = $("#list").datagrid("getSelections")
				 if(rows.length!=1){
				 	$.messager.alert("提示","只能修改一行","warning")
					 return
				 }
				 //表单回显
				 $("#editForm").form("load","customer/findById?id="+rows[0].id)

				 $("#win").window("open")
			})
			$("#deleteBtn").click(function(){
				var rows = $("#list").datagrid("getSelections")
				if(rows.length==0){
					$.messager.alert("提示","至少删除一行","warning")
					return
				}
				$.messager.confirm("提示","确认删除数据吗？",function (value) {
					if(value){
						var ids = ""
						// alert("admin")
						$(rows).each(function (i) {
							ids+=(rows[i].id+",");
						})
						ids = ids.substring(0,ids.length-1)
						// alert(ids)
						$.post("customer/delete",{"ids":ids},function (data) {
							if(data.success){
								//刷新datagrid
								$("#list").datagrid("reload");
								$.messager.alert("提示","删除成功","info")
							}else{
								$.messager.alert("提示","删除失败"+data.msg,"error")
							}
						},"json")
					}
				})
			})
		});
  	</script>
  </body>
</html>
