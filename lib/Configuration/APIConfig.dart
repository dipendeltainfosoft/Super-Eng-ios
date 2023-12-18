// ! Galaxy Link

//Username : aaa
//Password : 123456
// "http://13.235.202.211/SuperEng/DeltaKanban/API"
String baseUrl = "http://13.235.202.211/SuperEng/DeltaKanban/API/";
// String baseUrl = "http://dukeapikanban.deltasoftware.in/API/";

// ! Authentication API
String loginURL = baseUrl + "API_LoginWithFCMId.aspx";

// ! Department API
String getDeptList = baseUrl + "API_DeptWiseEmpHierarchy.aspx";

// ! Entry Level API
String prEntryURL = baseUrl + "API_InsertPRNewEntry.aspx";

// ! Auto Generate Code

String getPRNOURL = baseUrl + "API_GetPRNo.aspx";
String getPOWONOURL = baseUrl + "API_GetPOWONo.aspx";

// !Get

String getPayReqList = baseUrl + "API_PREditList.aspx";

// ! Approval

String tlAppURL = baseUrl + "API_PRTLApproval.aspx";
String gstAppURL = baseUrl + "API_PRGSTApproval.aspx";
String accAppURL = baseUrl + "API_AccApproval.aspx";
String bankAppURL = baseUrl + "API_PRBankingApproval.aspx";
String accHODAppURL = baseUrl + "API_PRAccHODApproval.aspx";

String profileDetailsURL = baseUrl + "API_ProfileDetails.aspx";
String profileUpdateDetailsURL = baseUrl + "API_ProfileDetailsUpdate.aspx";
String notificationURL = baseUrl + "API_NotificationLists.aspx";

String empListURL = baseUrl + "API_EmpList.aspx";
String taskApprovalListURL = baseUrl + "API_TaskApprovalList.aspx";
String reqApprovalListURL = baseUrl + "API_TargetDateApprovalList.aspx";
String updateApprovalListURL = baseUrl + "API_TaskApproval.aspx";
String updateReqApprovalListURL = baseUrl + "API_ApproveTargetDate.aspx";
String taskList = baseUrl + "API_TaskList.aspx";
String remarksList = baseUrl + "API_RemarkHistory.aspx";
String updateTaskList = baseUrl + "API_UpdateTask.aspx";
String projectListURL = baseUrl + "API_Projects.aspx";
String statusListURL = baseUrl + "API_Status.aspx";
String updateStatusURL = baseUrl + "API_UpdateTaskStatus.aspx";
String deletTaskURL = baseUrl + "API_DeleteTask.aspx";
String updateTaskDetailURL = baseUrl + "API_TaskDetailUpdate.aspx";
String updateTargetDateURL = baseUrl + "API_AddTargetRequisition.aspx";
String taskDetailURL = baseUrl + "API_TaskDetail.aspx";
String insertTask = baseUrl + "API_InsertTask.aspx";
String getEmpByDPID = baseUrl + "API_GetEmpData.aspx";






//Daily Checklist : 2
//Objective : 3
//Kanban : 1