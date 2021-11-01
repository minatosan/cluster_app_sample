$(document).on('turbolinks:load',function(){ 

  var search_list = $("#user-search-result");
  var member_list = $("#member_search_result");

  function appendUsers(profiles) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${profiles.nickname}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${profiles.id}" data-user-name="${profiles.nickname}">追加</div>
                </div>`
                
                 search_list.append(html);
                 
   }
   function addusers(userName,userId){
   var html =`<div class='chat-group-user'>
                <input name='group[profile_ids][]' type='hidden' value=${userId}>
                <p class='chat-group-user__names'>${userName}</p>
                <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
              </div>`  
              member_list.append(html);
              $("#user-search-result").empty();
   }
   $("#user-search-result").on("click", ".chat-group-user__btn--add", function () {
              var userName= $(this).data('user-name');
              var userId= $(this).data('user-id');
              addusers(userName,userId);
              $("#user-search-field").val("");
});

$(document).on("click", '.user-search-remove', function() {
  $(this).parent().remove();
});
   
   $("#user-search-field").on("keyup", function() {
      var input = $("#user-search-field").val();

   
      $.ajax({
        type: 'GET',
        url: "/profiles",
        data:  { keyword: input },
        dataType: 'json',
        contentType: false
      })
      .done(function(profiles) {
        $("#user-search-result").empty();
        if (profiles.length !== 0) {
          profiles.forEach(function(profiles){
            appendUsers(profiles);
          });}
        }
      )
      .fail(function() {
        alert('ユーザー検索に失敗しました');
      })
    })})