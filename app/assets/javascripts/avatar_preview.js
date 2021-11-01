$(function(){
  function readURL(input){
    if(input.files && input.files[0]){
      var reader =new FileReader();
      reader.onload=function(e){
        $("#avatar-preview").attr("src",e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
    }
    $("#avatar-img").change(function(){
      readURL(this);
    });
});


$(function(){
  function readURL(input){
    if(input.files && input.files[0]){
      var reader =new FileReader();
      reader.onload=function(e){
        $(".profile-edit-img").attr("src",e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
    }
    $("#profile_avatar").change(function(){
      readURL(this);
    });
});

