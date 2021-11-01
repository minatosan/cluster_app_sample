import React, { Component } from 'react';
import {Map, InfoWindow, Marker, GoogleApiWrapper} from 'google-maps-react';
import { iconPath } from "../packs/assets.js.erb";
import  Geocode from "react-geocode"

// set Google Maps Geocoding API for purposes of quota management. Its optional but recommended.


// Get latitude & longitude from address.

export class MapContainer extends Component {
  constructor (props) {
    super(props);
    this.onMarkerClick = this.onMarkerClick.bind(this);
    this.onGroupMarker= this.onGroupMarker.bind(this);
    this.handleChangePlace=this.handleChangePlace.bind(this);
    this.handleSearch=this.handleSearch.bind(this);
    this.geocodeMarker=this.geocodeMarker.bind(this);
    this.geocodeinfoWindow=this.geocodeinfoWindow.bind(this);
    this.onlistClick=this.onlistClick.bind(this);
    this.state = {
        lat: 35.68123620000001,
        lng: 139.7671248,
        showingInfoWindow: false,
        activeMarker: {},
        selectedPlace: {},
        places: [],
        address: "東京駅",
        value:"",
        geocode:[{lat: 0,lng:0}],
        geocodeMarker:false
    }
  }

  componentDidMount () {
    Geocode.setApiKey(process.env.GOOGLE_API);
    
  }
  componentDidUpdate(){
    //this.geocodeMarker();
  }

  

  onMarkerClick (props, marker, e) {
    this.setState({
      selectedPlace: props,
      activeMarker: marker,
      showingInfoWindow: true
    });
  };
  handleSearch() {
    Geocode.fromAddress(this.state.value).then(
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
    value: e.target.value
   })
  }
  onGroupMarker = () =>{
    return this.props.articles.map((store,index)=>{
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
  geocodeMarker(){
    return <Marker  position={{
      lat: this.state.geocode[0],
      lng: this.state.geocode[1]
    }}
    onClick={this.geocodeinfoWindow}/>
  }
  onlistClick(e){
    this.setState({
      title: e.target.value,
      lat:e.target.attributes.lat.nodeValue,
      lng:e.target.attributes.lng.nodeValue
    })}
  geocodeinfoWindow(props, marker, e){
    this.setState({
      selectedPlace: props,
      activeMarker: marker,
      showingInfoWindow: true,
      geocodeMarker: true
    });
    return <InfoWindow
    marker={this.state.activeMarker}
    visible={this.state.showingInfoWindow}
  >
  </InfoWindow>
  }


  render() {
    const containerStyle = {
      position: 'relative',  
      width: '800px',
      height: '550px',
      display:"inline-block"
    }
    const article_id=`/articles/${this.state.selectedPlace.id}`
    const thumbnail2= `/${this.state.selectedPlace.picture}`.match(/[^/]+$/);
    const thumbnail= `${iconPath}/${this.state.selectedPlace.picture_id}/${thumbnail2}`
    
    
    return (
      <div className="container place-map">
       
   
            <Map className="group-map"
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
               <div><a href={article_id} ><p>記事名:{this.state.selectedPlace.title}</p>
                </a>
                <img src={thumbnail} width="150px" height="150px"/>
                <p>
                  {this.state.selectedPlace.introduction}
                </p>
               </div>
              </InfoWindow>
            </Map>
            <ul className="group-map">
              記事名:
              {this.props.articles.map((article,index)=>
                <li key={index} ><button value={article.title} lat={article.lat} lng={article.lng}onClick={this.onlistClick} >{article.title}</button></li>)}
            </ul>
      </div>
    );
  }
}

export default GoogleApiWrapper({
  apiKey: (process.env.GOOGLE_API)
})(MapContainer);
