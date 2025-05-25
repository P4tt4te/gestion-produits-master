-- Table structure for table `produits`
CREATE TABLE IF NOT EXISTS produits (
  PRO_id SERIAL PRIMARY KEY,
  PRO_lib varchar(200) NOT NULL,
  PRO_prix decimal(10,2) NOT NULL,
  PRO_description text
);

-- Table structure for table `ressources`
CREATE TABLE IF NOT EXISTS ressources (
  RE_id SERIAL PRIMARY KEY,
  RE_type varchar(100) NOT NULL,
  RE_url varchar(1000) NOT NULL,
  RE_nom varchar(100) DEFAULT NULL,
  PRO_id integer NOT NULL,
  CONSTRAINT ressources_produits_FK FOREIGN KEY (PRO_id) REFERENCES produits (PRO_id)
);

-- Table structure for table `utilisateurs`
CREATE TABLE IF NOT EXISTS utilisateurs (
  US_id SERIAL PRIMARY KEY,
  US_login varchar(50) NOT NULL UNIQUE,
  US_password varchar(255) NOT NULL,
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert admin user
INSERT INTO utilisateurs (US_login, US_password) 
VALUES ('admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8')
ON CONFLICT (US_login) DO NOTHING;

-- Insert products
INSERT INTO produits (PRO_id, PRO_lib, PRO_prix, PRO_description) VALUES 
(1, 'Pédales Shimano XT M8040 M/L', 74.99, 'Les pédales plates SHIMANO XT PD-M8040 sont destinées à un usage All Mountain/Enduro. Très solides grâce à leur axe en acier chromoly, elles se caractérisent notamment par leur plateforme concave, qui accueille 10 picots dévissables, qui favorisent le grip sous la semelle. Leur structure est également plus ouverte et dégagée, qui empêche la boue de s''accumuler. Ces pédales XT Deore sont proposées ici en taille ML, mieux adaptée aux chaussures dont la pointure est comprise entre 43 et 48.'),
(2, 'Selle FIZIK ARIONE VERSUS Rails Kium', 59.99, 'Modèle confortable avant tout, la selle FIZIK Arione Versus possède un profil tout à fait plat et très long (300 mm) qui convient aux pratiquants justifiant d''une excellente souplesse vertébrale. Sa surface présente un canal central évidé, caractéristique des selles de la ligne Versus, qui permet de réduire les points de pression sur la zone périnéale. L''Arione Versus présente des rails légers et résistants en matériau Kium, et une coque associant du carbone à du nylon, pour offrir un supplément de souplesse aux endroits où les cuisses entrent en contact avec la selle, durant la phase de pédalage.'),
(3, 'Chaussures VTT MAVIC CROSSMAX SL PRO THERMO Noir', 164.99, 'Les chaussures Cross Max SL Pro Thermo créées par la marque MAVIC plairont aux riders voulant profiter de leur vélo en hiver ! Elles offrent une protection optimale contre le froid et contre la pluie. Elles disposent notamment d''une grande étanchéité Clima Ride assurée par une membrane Gore-Tex® haut de gamme associé à une protection de la cheville en néoprène avec fermeture éclair étanche. Idéal pour les météos les plus rudes ! Le maintien et le confort sont quant à eux garantis par les technologies MAVIC : le serrage à molette de précision Ergo Dial® notamment, d''une grande facilité et permettant un ajustement au millimètre ! La semelle interne Ergo Fit 3D Ortholite® est ergonomique, tout en offrant un bon amorti pour un confort supérieur. Les performances et la rigidité de la semelle externe Energy Grip Terra® vous permettront un pédalage efficace et un vrai confort lorsqu''il faudra marcher. Ces chaussures disposent en plus d''une semelle externe Contagrip® avec de bons crampons pour une accroche optimale même dans la boue. Des éléments réfléchissants ont été ajoutés pour une splendide finition !'),
(4, 'Pack GPS GARMIN EDGE 1030 + Ceinture Cardio', 519.99, 'Le Pack GPS Edge 1030 plus la ceinture cardio de Garmin est fait pour les compétiteurs et les adeptes de performances. Cette offre ravira les cyclistes souhaitant s''entraîner efficacement pour la saison !'),
(5, 'Fourche DVO SAPPHIRE 29', 549.99, 'Dérivée de la Diamond, la fourche DVO Sapphire 29" marque l''entrée de la marque californienne dans le segment des fourches Trail / All Mountain. Destinée aux cadres au standard Boost, elle procure un maximum de précision et de contrôle, et permet ainsi de monter, outre des pneus 29", des pneus 27,5" Plus jusqu''à 3,00" de section.')
ON CONFLICT (PRO_id) DO NOTHING;

-- Insert resources
INSERT INTO ressources (RE_id, RE_type, RE_url, RE_nom, PRO_id) VALUES
(40, 'img', 'uploads/3-ad201839b2ed3d2e4dae6c4f60c4b351.jpg', NULL, 3),
(41, 'img', 'uploads/3-7e147d9390a77334782851729ed8384f.jpg', NULL, 3),
(42, 'img', 'uploads/3-82fde3218e6f64fa94e8139fe80f7917.jpg', NULL, 3),
(43, 'img', 'uploads/5-19b235d023eef2281304433f0d4438b6.jpg', NULL, 5),
(44, 'img', 'uploads/5-b02cbdbc96d5c9a20526763576f56a11.jpg', NULL, 5),
(45, 'img', 'uploads/5-8e258524bf0f2aae28647a1aa8a77a8c.jpg', NULL, 5),
(46, 'img', 'uploads/4-a21d716bdfda2004d50171559c4b1b92.jpg', NULL, 4),
(47, 'img', 'uploads/4-1cb57a6c1de5c2573679654054a2b3b0.jpg', NULL, 4),
(48, 'img', 'uploads/4-438b7f4eec56d20aca694793882909ac.jpg', NULL, 4),
(49, 'img', 'uploads/1-707116622e5d4fe50dfc6391af4a5421.jpg', NULL, 1),
(50, 'img', 'uploads/1-7f8aacccd9c522281c58e5eb90cbb6a8.jpg', NULL, 1),
(51, 'img', 'uploads/1-987e17d65fb62e5fece343304d7be827.jpg', NULL, 1),
(52, 'img', 'uploads/2-e2b9f326909fe34dc9f73e515d0e5633.jpg', NULL, 2),
(53, 'img', 'uploads/2-5dfd065b9d05455732d122cdc3b64e27.jpg', NULL, 2),
(54, 'img', 'uploads/2-7e38160b643cf0e21ff445c9594e77d7.jpg', NULL, 2),
(55, 'img', 'uploads/2-2228cc7d3b9f647bfa31dd4ebf0f3885.jpg', NULL, 2)
ON CONFLICT (RE_id) DO NOTHING; 