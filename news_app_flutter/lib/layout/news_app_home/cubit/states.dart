abstract class NewsAppStates{}

class NewsAppInitialStates extends NewsAppStates{}
class NewsAppGetDataSuccessStates extends NewsAppStates{}
class NewsAppGetDataErrorStates extends NewsAppStates{
  String error;
  NewsAppGetDataErrorStates(this.error);
}
class NewsAppLoadingInitialStates extends NewsAppStates{}
class NewsAppBottomNavChangeStates extends NewsAppStates{}

