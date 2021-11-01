import React, { Component } from 'react';
import { GoogleApiWrapper, Map, Marker,InfoWindow} from 'google-maps-react';
import { iconPath } from "../packs/assets.js.erb";
import  Geocode from "react-geocode";
//require('dotenv').config();

export class MapContainer extends Component {
  constructor(props) {
    super(props);
    this.onMarkerClick = this.onMarkerClick.bind(this);
    this.displayMarkers = this.displayMarkers.bind(this);
    this.groupset= this.groupset.bind(this);
    this.onGroupMarker= this.onGroupMarker.bind(this);
    this.onlistClick=this.onlistClick.bind(this);
    this.handleChangePlace=this.handleChangePlace.bind(this);
    this.handleSearch=this.handleSearch.bind(this);
    this.geocodeMarker=this.geocodeMarker.bind(this);
    this.geocodeinfoWindow=this.geocodeinfoWindow.bind(this);
    this.state = {
      showingInfoWindow: false,
      activeMarker: {},
      selectedPlace: {},
      value: 1,
      group: "未登録",
      title:"",
      address: "",
      text:"",
      lat:35.68123620000001,
      lng:139.7671248,
      geocode:[{lat: 0,lng:0}],
      geocodeMarker:false
    }
    
  }
  componentDidMount(){
    Geocode.setApiKey(process.env.GOOGLE_API);
    if (this.props.articles.length >= 1){
    this.setState({
      lat:this.props.articles[0].lat,
      lng:this.props.articles[0].lng
    })}
  }

  displayMarkers = () => {
    return this.props.articles.map((store, index) => {
      return <Marker key={index} id={store.id} title={store.title} picture={store.article_images[0].picture.url}
      picture_id={store.article_images[0].id}
      introduction={store.introduction} 
      group={store.group_id}
      position={{
       lat: store.lat,
       lng: store.lng
     }}
     onClick={this.onMarkerClick} />
    })
  }
  onMarkerClick (props, marker, e) {
    this.setState({
      selectedPlace: props,
      activeMarker: marker,
      showingInfoWindow: true,
      geocodeMarker:false
    });
  
  };
  groupset(e){
    this.setState({
      value: e.target.selectedOptions[0].id,
      group: e.target.value
    })
  
}
onlistClick(e){
  this.setState({
    title: e.target.value,
    lat:e.target.attributes.lat.nodeValue,
    lng:e.target.attributes.lng.nodeValue
  })
}
onGroupMarker = () =>{
  const filterlist=this.props.articles.filter((article) => {
    return article.group_id == this.state.value })
  return filterlist.map((store,index)=>{
     return <Marker key={index} id={store.id} title={store.title} picture={store.article_images[0].picture.url}
    picture_id={store.article_images[0].id}
    introduction={store.introduction} 
    group={store.group_id}
    position={{
     lat: store.lat,
     lng: store.lng
   }}
   onClick={this.onMarkerClick} />
  })
}

handleSearch() {
  Geocode.fromAddress(this.state.text).then(
    response => {
      const { lat, lng } = response.results[0].geometry.location;
      this.setState({
        geocode:[lat,lng]
      })
      {this.geocodeMarker(this.state.geocode)}
    },
    error => {
      console.error(error);
    }
  );
}
handleChangePlace(e) {
 this.setState({
  text: e.target.value
 })
 
}

geocodeMarker(){
  return <Marker  position={{
    lat: this.state.geocode[0],
    lng: this.state.geocode[1]
  }}
  onClick={this.geocodeinfoWindow}/>
}
geocodeinfoWindow(props, marker, e){
  this.setState({
    selectedPlace: props,
    activeMarker: marker,
    showingInfoWindow: true,
    geocodeMarker: true
  });
}
  
  render() {
    const containerStyle = {
      position: 'relative',  
      width: '800px',
      height: '550px'
    }
    const lat=this.state.geocode[0]
    const lng=this.state.geocode[1]
    const group_id=`/groups/${this.state.value}`
    const new_article=`/articles/new?lat=${this.state.geocode[0]}&lng=${this.state.geocode[1]}`
    const article_id=`/articles/${this.state.selectedPlace.id}`
    const thumbnail2= `/${this.state.selectedPlace.picture}`.match(/[^/]+$/);
    const thumbnail= `${iconPath}/${this.state.selectedPlace.picture_id}/${thumbnail2}`
    const filterlist=this.props.articles.filter((article) => {
      return article.group_id == this.state.value })
    const geocodeWindow = this.state.geocodeMarker;
    let button;
    if (geocodeWindow) {
      button =<div><a href={new_article}> 新規記事作成へ</a></div>;
    } else {
      button = <div><a href={article_id} ><p>記事名:{this.state.selectedPlace.title}</p>
      </a>
      <img src={thumbnail} width="150px" height="150px"/>
      <p>
        {this.state.selectedPlace.introduction}
      </p>
      </div>;
    }


    return (
      <div>
        <input className="map-input" type="text"  value={this.state.text}
        onChange={ this.handleChangePlace } placeholder="ここに住所を入力してください"></input>
        <button className="map-button" onClick={this.handleSearch}>新規アルバムの作成</button>
        所属グループリスト<select onChange={this.groupset}>
          {this.props.article_group.map((article_group,index)=><option id={article_group.id}key={index}>{article_group.name}</option>)}
        </select>
        
        <Map
          className="group-map"
          google={this.props.google}
          zoom={10}
          center={{ lat: this.state.lat, lng: this.state.lng   }}
          initialCenter={{ lat: this.state.lat, lng: this.state.lng   }}
          containerStyle={containerStyle}
        >
          {this.geocodeMarker(this.state.geocode)}
          {this.onGroupMarker()}
          <InfoWindow
                marker={this.state.activeMarker}
                visible={this.state.showingInfoWindow}
              >
                {button}
          </InfoWindow>
        </Map>
        <ul className="group-map">
        <a href={group_id}>{this.state.group}</a> 
        <br/>記事一覧
          {filterlist.map((article,index)=>
            <li key={index} ><button value={article.title} lat={article.lat} lng={article.lng}onClick={this.onlistClick} >{article.title}</button></li>)}
        </ul>
      </div>
    );
  }
}



export default GoogleApiWrapper({
  apiKey: (process.env.GOOGLE_API)
})(MapContainer);


