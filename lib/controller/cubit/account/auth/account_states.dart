abstract class AccountStates {}

class CoinsInitial extends AccountStates {}

class RegisterSuccessEmail extends AccountStates{}
class RegisterFailedEmail extends AccountStates{}
class SaveDataToFireStoreEmail extends AccountStates{}
class ErrorDataToFireStoreEmail extends AccountStates{}

class FailedToLogin extends AccountStates{}
class LoginSuccessfully extends AccountStates{}

class LoadingImageState extends AccountStates{}
class SuccessfullyStoredImage extends AccountStates{}
class FailedToStoreImage extends AccountStates{}

class SignOutState extends AccountStates{}