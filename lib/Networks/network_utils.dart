class NetworkUtils{
  static const String _baseURL = "https://ecom-rs8e.onrender.com/api";

  static String userLogin = "$_baseURL/auth/login";

  static String userSignUp = "$_baseURL/auth/signup";

  static String verifyLogin = "$_baseURL/auth/verify-otp";

  static String resendOTP = "$_baseURL/auth/resend-otp";

  static String readProfile = "$_baseURL/ReadProfile";

  static String sliderList = "$_baseURL/slides";

  static String categoryList = "$_baseURL/categories";
}