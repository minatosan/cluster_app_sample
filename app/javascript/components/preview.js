import React, { useState } from "react";

export default function App(props) {
  const [value, setValue] = useState(props.articles[0].introduction)
  const image=props.articles
  const[preview,setPreview]=useState(props.articles[0].picture.url)
  
  function imageclick(e){
    setValue(props.articles[e.target.dataset.value].introduction)
    setPreview(props.articles[e.target.dataset.value].picture.url)
   }
  const images =image.map((index,counter)=>{
    return <li key={index.id} className="article-show-picture">
           <img className="article-pictures" src={index.picture.url} height="100px" width="100px"  data-value={counter} onClick={imageclick}></img>
           </li>          
  })
  return (
    <div className="article-show-under-box">
      <div className="article-show-under__block">
        <div className="article-show-images__box">
      {images}
        </div>
      </div>
      <div className="article-show-under__block">
        <img className = "article-show-preview" src={preview} width="250px"  height="250px" ></img>
      </div> 
      <div className="picture-comment">
        {value}
      </div>
    </div>
  );
}
