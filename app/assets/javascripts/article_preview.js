$(document).on('turbolinks:load',function(){
    //該当するURLの場合だけ処理を行う
    var re = new RegExp('/articles/new|/articles$');
    if(!re.test(location.pathname)) {
   return;
    }
   let fileIndex = 0
   //HTMLを作成する関数を定義
   function buildHTML(num){
     var html=`<div class = "img-view">
     <img class="preview" width="150px" height="150px" data-index="${num}">
     <textarea class="preview-text"name="article[article_images_attributes][${fileIndex}][introduction]"rows="8" cols="30"></textarea>
     <div class="btn-wrapper">
       <div class="btn-edit">編集</div>
       <div class="btn-delete">削除</div>
     </div>
     
   </div>`;
   fileIndex += 1
   return html
   }
  //preview群にIDを定義
   $('.preview').each(function(index, box){
    $(box).attr('id', `preview__${index}`);
  })
  //削除ボタンにidを追加
  $('.btn-delete').each(function(index, box){
    $(box).attr('id', `btn-delete__${index}`);
  })
 
  $(document).on('change', 'input[type="file"]', function() {
    changed_input = $(this).parent().data('index');
    
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    // ファイル読み込み後の処理
    
    if($(".preview").length >= 10 ){
      return false;
    }
    else if($(`.preview[data-index=${changed_input}]`).length == 0){
      $(".article-new-preview").append(buildHTML(fileIndex));
    }
    var new_input = $(`<div class = "article-new-input" data-index="${fileIndex}">

    <input class="upload-image" type="file" accept="image/jpg,image/jpeg,image/png"
    name="article[article_images_attributes][${fileIndex}][picture]">
                       </div>`
    );
    

    if($(`.preview`).length == 1 && $(".article-new-input").length ==1){
      $(".article-new-file-field").append(new_input);
    }else if($(".article-new-input").length >= 10){
      return false;
    }else if($(".article-new-input").length == $(".preview").length){
     $(".article-new-file-field").append(new_input);
    }
    
   
    reader.onload = function(e) {
      // img_view内のimgタグのsrcプロパティへ、読み込みが完了した画像を入れ込む
      $(".img-view").find(`.preview[data-index=${changed_input}]`).attr('src', e.target.result);
    };

    // FileReaderオブジェクトへ属性値(filesプロパティ)を代入する
    reader.readAsDataURL(file);

    
  })
  $(document).on('click', '.btn-delete', function() {
    var new_input = $(`<div class = "article-new-input" data-index="${fileIndex}">

    <input class="upload-image" type="file" accept="image/jpg,image/jpeg,image/png"
    name="article[article_images_attributes][${fileIndex}][picture]">
                       </div>`
    );
    var target_image = $(this).parent().parent();
    var remove_id = target_image.find(".preview").data('index');
    var remove_image= $('.article-new-input[data-index='+remove_id+']');
    target_image.remove();
    if($(".preview").length ==  10){
      target_image.remove();
      remove_image.remove();
      $(".article-new-file-field").append(new_input);
    }
    else{
    target_image.remove();
    remove_image.remove();
    }
  });
});
