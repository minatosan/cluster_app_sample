

## 使用技術

Ruby 2.６.３ 

Ruby on Rails 5.2.4

MySQL 5.7

Docker/Docker-compose

Puma

Rspec

Google Maps API

React

Webpacker

jquery



以下の技術についてはデプロイ後、実装していく予定です。。。

AWS
 * VPC 
 * EC2
 * Route53
 
Nginx

## 機能一覧
* ユーザー登録、ログイン機能(Device)
* グループ作成機能
* 投稿機能
* 画像投稿（carrierwave)
* 位置情報検索機能(google maps api)
* 画像プレビュー機能（Jquery)
* ページネーション機能(kaminari)
  
## サービス概要
自分だけの、自分と友達だけのGoogle Mapsを作るサービスです！

Google Maps APIにて位置情報を検索し、記事を投稿。

投稿した記事がGoogle MAPS上にマーカーとして出現します

併せて記事をグループ単位にカテゴライズすることで、コミュニティだけのGoogle　Mapsを作成できます。

## サービスを作った背景
　　私は友達と旅行に行くことがあるのですが、写真の管理がLINEのアルバム機能で管理しておりました。
 
 自分が不便に感じた点として、
 
 * LINEのアルバム機能では写真が一覧で表示されるだけで一枚ごとにコメントができない
 * また、写真を見返す時に特定の写真を見つけるのが手間だった
 * 友達と特定の写真について会話する時に、LINEで画像を再送するなどしていた
  
　　以上の理由から、写真・思い出を共有するWebアプリを作成しようと考えました。
 
  
  

  
  　　
