-- ===================================================================
--                PROJET SAE - BASE DE DONNÉES E-COMMERCE
--               RÉALISÉ PAR : EWEN GILBERT ET ELIAN TELLE
-- ===================================================================

-- ===================================================================
--                LISTE DES TABLES DE LA BASE DE DONNÉES
-- ===================================================================


--CÔTÉ UTILISATEUR

--UTILISATEUR(loginU, prenom, nom, email, genre, tel)
--PANIER(idPanier,#loginU)
--ADRESSE(idAdresse, numéro, rue, ville, région, pays, info_comp)
--UT_POSSEDE_ADRESSE(#loginU, #idAdresse)
--NOTE(idNote,score,#loginU, #idArticle)
--COMMENTAIRE(idCom, titre, description, date, #loginU, #idArticle, #idComParent, #idNote)
--ARTICLE_PANIER(idArticleP, quantité, #idPanier, #idArticle)
--SOUHAIT(#loginU, #idArticle)
--
--CÔTÉ EMPLOYES :
--
--EMPLOYE(loginE, nom, prenom, email, num_tel, genre, poste, #idAdresse)
--
--CÔTÉ ARTICLE :
--
--VENDEUR(loginV, nom, adresse, pays, ville, num_tel, slug)
--VENTE(#IdArticle,#loginV)
--ARTICLE(idArticle, nom, description, prix, stock, #loginV, #idCategorie)
--PROMO_APPLIQUE_ARTICLE(#idArticle,#idPromo)
--PROMO_APPLIQUE_CAT(#idCategorie,#idPromo)
--ARTICLE_CATEGORIE(#idArticle, #idCategorie)
--CATEGORIE_SOUSCAT(#idCategorie, #idCategorie)
--CATÉGORIE(idCategorie, nom)
--IMAGE(idImage, nom, lien, #idArticle)
--PROMOTION(idPromo, nom, pourcentage, valeur, code, type)
--
--CÔTE ACHAT :
--
--ARTICLE_LIVRAISON(idArticleLivraison, prix, quantité, #idLivraison, #idArticleCommande, #loginE)
--LIVRAISON(idLivraison, date, temps, statut, #idAdresse, #loginE)
--ARTICLE_COMMANDE(idArticleCommande, prix, quantité, #idCommande, #idArticle)
--COMMANDE(idCommande, date, #loginU)
--FACTURE(idFacture, date, moyenPaiement, #loginU)
--ARTICLE_FACTURE(idArticleFacture, prix, quantité, #idFacture, #idArticleCommande)

-- ==============================================================
--                SUPPRESSION DES TABLES
-- ==============================================================

DROP TABLE UTILISATEUR CASCADE CONSTRAINTS;
DROP TABLE ADRESSE CASCADE CONSTRAINTS;
DROP TABLE UT_POSSEDE_ADRESSE CASCADE CONSTRAINTS;
DROP TABLE NOTE CASCADE CONSTRAINTS;
DROP TABLE COMMENTAIRE CASCADE CONSTRAINTS;
DROP TABLE PANIER CASCADE CONSTRAINTS;
DROP TABLE ARTICLE_PANIER CASCADE CONSTRAINTS;
DROP TABLE SOUHAIT CASCADE CONSTRAINTS;
DROP TABLE VENDEUR CASCADE CONSTRAINTS;
DROP TABLE VENTE CASCADE CONSTRAINTS;
DROP TABLE ARTICLE CASCADE CONSTRAINTS;
DROP TABLE PROMO_APPLIQUE_ARTICLE CASCADE CONSTRAINTS;
DROP TABLE PROMO_APPLIQUE_CAT CASCADE CONSTRAINTS;
DROP TABLE ARTICLE_CATEGORIE CASCADE CONSTRAINTS;
DROP TABLE CATEGORIE_SOUSCAT CASCADE CONSTRAINTS;
DROP TABLE CATEGORIE CASCADE CONSTRAINTS;
DROP TABLE IMAGE CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE EMPLOYE CASCADE CONSTRAINTS;
DROP TABLE ARTICLE_LIVRAISON CASCADE CONSTRAINTS;
DROP TABLE LIVRAISON CASCADE CONSTRAINTS;
DROP TABLE ARTICLE_COMMANDE CASCADE CONSTRAINTS;
DROP TABLE COMMANDE CASCADE CONSTRAINTS;
DROP TABLE FACTURE CASCADE CONSTRAINTS;
DROP TABLE ARTICLE_FACTURE CASCADE CONSTRAINTS;

-- ==============================================================
--                  CREATION DES TABLES
-- ==============================================================

CREATE TABLE UTILISATEUR(
    loginU VARCHAR(30) PRIMARY KEY,
    prenom VARCHAR(30) NOT NULL,
    nom VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL CHECK (email LIKE '%_@%.__%'), --Vérifie que l'email est bien de la forme "___@___.___"
    genre VARCHAR(10) NOT NULL,
    tel VARCHAR(10) NOT NULL
);

CREATE TABLE PANIER(
    idPanier INT PRIMARY KEY,
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU)
);


CREATE TABLE VENDEUR(
    loginV VARCHAR(30) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    pays VARCHAR(50) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    num_tel VARCHAR(20) NOT NULL,
    slug VARCHAR(50) NOT NULL
);

CREATE TABLE ADRESSE(
    idAdresse INT PRIMARY KEY,
    numéro VARCHAR(20) NOT NULL,
    rue VARCHAR(100) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    région VARCHAR(50) NOT NULL,
    pays VARCHAR(50) NOT NULL,
    info_comp VARCHAR(200)
);

CREATE TABLE EMPLOYE(
    loginE VARCHAR(30) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL CHECK (email LIKE '%_@%.__%'), --Vérifie que l'email est bien de la forme "___@___.___"
    genre VARCHAR(10) NOT NULL,
    num_tel VARCHAR(20) NOT NULL,
    poste VARCHAR(50) NOT NULL,
    idAdresse INT REFERENCES ADRESSE(idAdresse)
);


CREATE TABLE CATEGORIE(
    idCategorie INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE ARTICLE(
    idArticle INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL,
    prix INT NOT NULL,
    stock INT NOT NULL,
    loginV VARCHAR(30) REFERENCES VENDEUR(loginV),
    idCategorie INT REFERENCES CATEGORIE(idCategorie)
);

CREATE TABLE SOUHAIT(
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE UT_POSSEDE_ADRESSE(
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU),
    idAdresse INT REFERENCES ADRESSE(idAdresse)
);

CREATE TABLE NOTE(
    idNote INT PRIMARY KEY,
    score INT NOT NULL,
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE COMMENTAIRE(
    idCom INT PRIMARY KEY,
    titre VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL,
    datecommentaire date NOT NULL,
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU),
    idArticle INT REFERENCES ARTICLE(idArticle),
    idComParent INT REFERENCES COMMENTAIRE(idCom),
    idNote INT REFERENCES NOTE(idNote)
);

CREATE TABLE ARTICLE_PANIER(
    idArticleP INT PRIMARY KEY,
    quantité INT NOT NULL,
    idPanier INT REFERENCES PANIER(idPanier),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE VENTE(
    idArticle INT REFERENCES ARTICLE(idArticle),
    loginV VARCHAR(30) REFERENCES VENDEUR(loginV)
);

CREATE TABLE PROMOTION(
    idPromo INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    pourcentage INT NOT NULL
);

CREATE TABLE PROMO_APPLIQUE_ARTICLE(
    idArticle INT REFERENCES ARTICLE(idArticle),
    idPromo INT REFERENCES PROMOTION(idPromo)
);

CREATE TABLE PROMO_APPLIQUE_CAT(
    idCategorie INT REFERENCES CATEGORIE(idCategorie),
    idPromo INT REFERENCES PROMOTION(idPromo)
);

CREATE TABLE ARTICLE_CATEGORIE(
    idArticle INT REFERENCES ARTICLE(idArticle),
    idCategorie INT REFERENCES CATEGORIE(idCategorie)
);

CREATE TABLE CATEGORIE_SOUSCAT(
    idCategorie INT REFERENCES CATEGORIE(idCategorie),
    idSousCat INT REFERENCES CATEGORIE(idCategorie)
);

CREATE TABLE IMAGE(
    idImage INT PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE COMMANDE(
    idCommande INT PRIMARY KEY,
    datecommande date NOT NULL,
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU)
);

CREATE TABLE ARTICLE_COMMANDE(
    idArticleCommande INT PRIMARY KEY,
    prix INT NOT NULL,
    quantité INT NOT NULL,
    idCommande INT REFERENCES COMMANDE(idCommande),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE LIVRAISON(
    idLivraison INT PRIMARY KEY,
    datelivraison date NOT NULL,
    temps INT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    loginE VARCHAR(30) REFERENCES EMPLOYE(loginE),
    idAdresse INT REFERENCES ADRESSE(idAdresse)
);

CREATE TABLE ARTICLE_LIVRAISON(
    idArticleLivraison INT PRIMARY KEY,
    prix INT NOT NULL,
    quantité INT NOT NULL,
    idLivraison INT REFERENCES LIVRAISON(idLivraison),
    idArticleCommande INT REFERENCES ARTICLE_COMMANDE(idArticleCommande)
);

CREATE TABLE FACTURE(
    idFacture INT PRIMARY KEY,
    datefacture date NOT NULL,
    loginU VARCHAR(30) REFERENCES UTILISATEUR(loginU),
    idCommande INT REFERENCES COMMANDE(idCommande)
);

CREATE TABLE ARTICLE_FACTURE(
    idArticleFacture INT PRIMARY KEY,
    prix INT NOT NULL,
    quantité INT NOT NULL,
    idFacture INT REFERENCES FACTURE(idFacture),
    idArticleCommande INT REFERENCES ARTICLE_COMMANDE(idArticleCommande)
);

-- ========================================
--          INSERTION DES DONNEES
-- ========================================

INSERT INTO UTILISATEUR VALUES ('egilbert','EWEN','GILBERT','wenwengilbert@gmail.com','H','0202020202');
INSERT INTO PANIER VALUES (1,'egilbert');
INSERT INTO VENDEUR VALUES ('etelle','amazon','25 rue des potiers','France','Paris','0123456789','Amazon');
INSERT INTO ADRESSE VALUES (1,'25bis','rue des potiers','Paris','Île de France','France','Troisième étage porte 302');
INSERT INTO ADRESSE VALUES (2,'89','rue des pommiers','Paris','Île de France','France','Premier étage');
INSERT INTO EMPLOYE VALUES ('jchiron','Chiron','Jules','juleschiron@gmail.com','H','0247552597','Modérateur',2);
INSERT INTO EMPLOYE VALUES ('pjauffres','Jauffres','Pierre','pierrejauffres@gmail.com','H','0254548785','Livreur',2);
INSERT INTO CATEGORIE VALUES (1,'Informatique');
INSERT INTO CATEGORIE VALUES (2,'Jardinage');
INSERT INTO ARTICLE VALUES (1,'Arrosoir connecté','Arrosoir connecté de couleur rouge de la marque IUT VELIZY INC.','5000','10','etelle',1);
INSERT INTO ARTICLE VALUES (2,'Pelle','Pelle de couleur rouge de la marque IUT VELIZY INC.','5000','10','etelle',2);
INSERT INTO SOUHAIT VALUES ('egilbert',1);
INSERT INTO UT_POSSEDE_ADRESSE VALUES ('egilbert',1);
INSERT INTO NOTE VALUES (1,5,'egilbert',1);
INSERT INTO COMMENTAIRE VALUES (1,'Très bon produit','Cet arroisoir est tout bonnement incroyable !',current_date,'egilbert',1,Null,1);
INSERT INTO ARTICLE_PANIER VALUES (1,5,1,1);
INSERT INTO ARTICLE_PANIER VALUES (2,2,1,2);
INSERT INTO VENTE VALUES (1,'etelle');
INSERT INTO VENTE VALUES (2,'etelle');
INSERT INTO PROMOTION VALUES (1,'PRIX CHOC!','Promotion de 10% sur les articles de la catégorie informatique',current_date,current_date+1,10);
INSERT INTO PROMOTION VALUES (2,'PROMO DE FOLIE','Promotion de 10% sur les pelles',current_date,current_date+1,10);
INSERT INTO PROMO_APPLIQUE_CAT VALUES (1,1);
INSERT INTO PROMO_APPLIQUE_ARTICLE VALUES (2,2);
INSERT INTO ARTICLE_CATEGORIE VALUES (1,1);
INSERT INTO ARTICLE_CATEGORIE VALUES (2,2);
INSERT INTO CATEGORIE_SOUSCAT VALUES (1,2);
INSERT INTO IMAGE VALUES (1,'https://www.arrosage-distribution.fr/media/wp/2015/05/arrosage-domotique.jpg',1);
INSERT INTO IMAGE VALUES (2,'https://media.adeo.com/marketplace/LMFR/15927233/f566055d-ecad-4917-972b-a8005b992efb.jpeg',2);
INSERT INTO COMMANDE VALUES (1,current_date,'egilbert');
INSERT INTO ARTICLE_COMMANDE VALUES (1,5000,5,1,1);
INSERT INTO LIVRAISON VALUES (1,current_date,2,'En attente','pjauffres',1);
INSERT INTO ARTICLE_LIVRAISON VALUES (1,5000,5,1,1);
INSERT INTO FACTURE VALUES (1,current_date,'egilbert',1);
INSERT INTO ARTICLE_FACTURE VALUES (1,5000,5,1,1);

-- ========================================
--          CREATION DES VUES
--      ET MISE EN PLACE DES DROITS
-- ========================================

--CREATE USER VISITEUR IDENTIFIED BY azerty ;
--CREATE ROLE CLIENT ;
--CREATE ROLE VENDEUR ;
--CREATE ROLE LIVREUR ;
--CREATE ROLE MODO ;

-- ========================================
--          Droits pour visiteurs
-- ========================================

GRANT SELECT ON VENDEUR, ARTICLE, IMAGE,  VENTE, CATEGORIE, CATEGORIE_SOUSCAT, ARTICLE_CATEGORIE, PROMOTION, PROMO_APPLIQUE_CAT, PROMO_APPLIQUE_ARTICLE, COMMENTAIRE, NOTE
            TO lecteur, client, vendeur, employe ;

CREATE VIEW profil_public AS (SELECT idUtilisateur, nom, prenom FROM UTILISATEUR) ;
GRANT SELECT ON profil_public TO lecteur, client, vendeur, employe ;

-- ========================================
--      Droits pour clients (inscrits)
-- ========================================

--Poster commentaire

CREATE VIEW nouveau_comm AS (SELECT titre, description, idArticle, idComParent, idNote);

GRANT INSERT ON nouveau_comm TO client, vendeur, livreur, employe;

--Modifier commentaires

CREATE VIEW comm_perso AS (SELECT titre, description FROM COMMENTAIRE 
                           WHERE loginU = USER);

GRANT SELECT, UPDATE, DELETE ON comm_perso TO client, vendeur, livreur, employe ;

--Regarder/modifier profil

CREATE VIEW profil_perso AS (SELECT prenom, nom, email, genre, tel FROM UTILISATEUR
                             WHERE loginU = USER) ;

GRANT SELECT, UPDATE ON profil_perso TO client ;

--Consulter/modifier ses adresses

CREATE VIEW adresse_perso AS (SELECT numero, rue, ville, region, pays, info_comp FROM ADRESSE WHERE idAdresse IN (SELECT idAdresse FROM UT_POSSEDE_ADRESSE WHERE loginU = USER))
GRANT SELECT, UPDATE, DELETE ON adresse_perso TO client

--Ajouter une adresse

CREATE VIEW nouv_adresse AS (SELECT numero, ville, region, pays, info_comp FROM ADRESSE) ;
CREATE VIEW liaison_adr AS (SELECT idAdresse FROM UT_POSSEDE_ADRESSE) ;

GRANT INSERT ON nouv_adresse TO client ;

--Creation de panier

CREATE VIEW nouv_panier AS (SELECT idPanier FROM PANIER);
GRANT INSERT ON nouv_panier TO client ;

--Ajout d'article au panier

CREATE VIEW nouv_article_panier AS (SELECT quantite, idPanier, idArticle FROM PANIER) ;
GRANT INSERT ON nouv_article_panier TO client ;

--Consulter/modifier souhait

CREATE VIEW souhait_perso AS (SELECT idArticle FROM SOUHAIT WHERE loginU = USER) ;
GRANT SELECT, UPDATE, DELETE ON souhait_perso TO client ;

--Créer souhait

CREATE VIEW nouv_souhait AS (SELECT idArticle FROM SOUHAIT) ;
GRANT INSERT ON nouv_souhait TO client ;

--Faire une commande

CREATE VIEW nouv_commande AS (SELECT idCommande FROM COMMANDE) ;
GRANT INSERT ON nouv_commande TO client ;

--Ajouter des articles à la commande

CREATE VIEW nouv_article_commande AS (SELECT quantite, idCommande, idArticle FROM COMMANDE) ;
GRANT INSERT ON nouv_article_commande TO client ;

-- ========================================
--          Droits pour vendeurs
-- ========================================
DROP VIEW ARTICLE_VENDEUR;
DROP VIEW PROMO_ARTICLE_VENDEUR;
DROP VIEW IMAGE_ARTICLE_VENDEUR;
 
CREATE VIEW ARTICLE_VENDEUR AS (SELECT * FROM ARTICLE WHERE loginV = USER);
GRANT INSERT,SELECT,DELETE,UPDATE ON ARTICLE_VENDEUR TO vendeur;
 
CREATE VIEW PROMO_ARTICLE_VENDEUR AS (SELECT * FROM PROMO_APPLIQUE_ARTICLE WHERE idArticle IN (SELECT idArticle FROM ARTICLE_VENDEUR));
GRANT INSERT,SELECT,DELETE,UPDATE ON PROMO_ARTICLE_VENDEUR TO vendeur;
 
CREATE VIEW IMAGE_ARTICLE_VENDEUR AS (SELECT * FROM IMAGE WHERE idArticle IN (SELECT idArticle FROM ARTICLE_VENDEUR));
GRANT INSERT,SELECT,DELETE,UPDATE ON IMAGE_ARTICLE_VENDEUR TO vendeur; 
 
-- ========================================
--      Droits pour les modérateurs
-- ========================================
 
GRANT DELETE,UPDATE,SELECT ON ARTICLE TO MODO;
GRANT DELETE,SELECT ON COMMENTAIRE TO MODO;
GRANT DELETE,SELECT ON NOTE TO MODO;
GRANT INSERT,SELECT,UPDATE,DELETE ON LIVRAISON TO MODO;
GRANT INSERT,SELECT,DELETE,UPDATE ON ARTICLE_LIVRAISON TO MODO;
GRANT INSERT,SELECT,DELETE,UPDATE ON COMMANDE TO MODO;
GRANT INSERT,SELECT,DELETE,UPDATE ON ARTICLE_COMMANDE TO MODO;
GRANT SELECT,UPDATE,INSERT,DELETE ON FACTURE TO MODO;
GRANT INSERT,SELECT,DELETE,UPDATE ON ARTICLE_FACTURE TO MODO;
GRANT SELECT,DELETE,UPDATE ON ARTICLE TO MODO;
GRANT SELECT,DELETE,UPDATE ON IMAGE TO MODO;
GRANT SELECT,DELETE,UPDATE ON PROMOTION TO MODO;
GRANT SELECT,UPDATE,DELETE ON UTILISATEUR TO MODO;
GRANT SELECT,UPDATE,DELETE ON ADRESSE TO MODO;
GRANT SELECT,UPDATE,DELETE ON VENDEUR TO MODO;
GRANT SELECT,UPDATE,DELETE ON ARTICLE_PANIER TO MODO;
GRANT SELECT,UPDATE,DELETE ON PANIER TO MODO;
GRANT SELECT,UPDATE,DELETE ON SOUHAIT TO MODO;

-- ========================================
--         Droits pour les livreurs
-- ========================================

DROP VIEW LIVRAISON_LIVREUR;
DROP VIEW ARTICLE_LIVRAISON_LIVREUR;
DROP VIEW ADRESSE_LIVRAISON;
DROP VIEW UTILISATEUR_LIVRAISON;

CREATE VIEW LIVRAISON_LIVREUR AS (SELECT * FROM LIVRAISON WHERE loginE = USER )
GRANT SELECT,UPDATE ON LIVRAISON_LIVREUR TO livreur;
CREATE VIEW ARTICLE_LIVRAISON_LIVREUR AS (SELECT * FROM ARTICLE_LIVRAISON WHERE idLivraison IN (SELECT idLivraison FROM LIVRAISON_LIVREUR));
GRANT SELECT ON ARTICLE_LIVRAISON_LIVREUR TO livreur;
CREATE VIEW ADRESSE_LIVRAISON AS (SELECT * FROM ADRESSE WHERE idAdresse IN (SELECT idLivraison FROM LIVRAISON_LIVREUR));
GRANT SELECT ON ADRESSE_LIVRAISON TO livreur;
CREATE VIEW UTILISATEUR_LIVRAISON AS (SELECT * FROM UTILISATEUR WHERE loginU IN (SELECT idLivraison FROM LIVRAISON_LIVREUR));
GRANT SELECT ON UTILISATEUR_LIVRAISON TO livreur;
 