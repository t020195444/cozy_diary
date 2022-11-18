class Api {
  //ip
  static String ipUrl = 'http://140.131.114.166:80/';
  //抓取使用者資料(Get)
  static String getUser = "getUser?gid=";
  //抓取使用者貼文(Get)
  static String getPostCoverForPersonalPage =
      "getPostCoverForPersonalPage?uid=";
  //追蹤(Post)
  static String addTracker = "addTracker";
  //取消追蹤(Post)
  static String deleteTracker = "deleteTracker?tid=";
  //抓取追蹤清單(Get)
  static String getTrackerList = "getTrackerList?uid=";
  //抓取粉絲清單(Get)
  static String getFollowerList = "getFollowerList?uid=";
  //更新使用者資料(Post)
  static String updateUser = "updateUser";
  //依類別抓取貼文主頁預設圖(Get)
  static String getPostCoverByUserCategory = 'getPostCoverByUserCategory?uid=';
  //新增貼文
  static String addPost = 'addPost';
  //修改貼文
  static String updatePost = 'updatePost';
  //新增活動
  static String addActivity = 'addActivity';

  //抓取貼文詳細資訊
  static String getPostDetail = "getPostDetail?pid=";

  //抓取貼文詳細資訊
  static String getActivityDetail = "getActivityDetail?aid=";
  //註冊使用者
  static String userRegister = "userRegister";
  //獲得全部類別名稱
  static String getCategoryList = "getCategoryList";
  //新增使用者類別
  static String addCategory = "addUserCategory";
  //抓取使用者類別
  static String userCategoryList = "userCategoryList?uid=";
  //新增留言
  static String postComment = '/addComment';
  //刪除留言
  static String deleteComment = 'deleteComment?cid=';
  //更新留言
  static String updateComment = 'updateComment?';
  //獲取全部語言
  static String getAllPost = "/getAllPost";
  //報名活動
  static String updateParticipant = "/updateParticipant";
  //依照類別抓貼文
  static String getPostCoverByCategory = "/getPostCoverByCategory?cid=";
  //審核貼文列表
  static String getParticipantList = "/getParticipantList?aid=";
  //審核通過/未審核
  static String updateApplication = "/updateApplication";
  //按讚/取消按讚
  static String updateActivityLikes = "/updateActivityLikes";
}
