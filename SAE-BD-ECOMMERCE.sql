"""
CÔTÉ UTILISATEUR

PANIER(idPanier)
UTILISATEUR(idUtilisateur, prenom, nom, email, genre, tel, #idPanier)
ADRESSE(idAdresse, numéro, rue, ville, région, pays, info_comp)
UT_POSSEDE_ADRESSE(#idUtilisateur, #idAdresse)
NOTE(idNote,score,#idUtilisateur, #idArticle)
COMMENTAIRE(idCom, titre, description, date, #idUtilisateur, #idArticle, #idCom, #idNote)
ARTICLE_PANIER(idArticleP, quantité, #idPanier, #idArticle)
SOUHAIT(#idUtilisateur, #idArticle)

CÔTÉ EMPLOYES :

EMPLOYE(idEmp, nom, prenom, email, num_tel, genre, poste, #idAdresse)

CÔTÉ ARTICLE :

VENDEUR(idVendeur, nom, adresse, pays, ville, num_tel, slug)
VENTE(#IdArticle,#idVendeur)
ARTICLE(idArticle, nom, description, prix, stock, #idVendeur, #idCategorie)
PROMO_APPLIQUE_ARTICLE(#idArticle,#idPromo)
PROMO_APPLIQUE_CAT(#idCategorie,#idPromo)
ARTICLE_CATEGORIE(#idArticle, #idCategorie)
CATEGORIE_SOUSCAT(#idCategorie, #idCategorie)
CATÉGORIE(idCategorie, nom)
IMAGE(idImage, nom, lien, #idArticle)
PROMOTION(idPromo, nom, pourcentage, valeur, code, type)

CÔTE ACHAT :

ARTICLE_LIVRAISON(idArticleLivraison, prix, quantité, #idLivraison, #idArticleCommande, #idEmp)
LIVRAISON(idLivraison, date, temps, statut, #idAdresse, #idEmp)
ARTICLE_COMMANDE(idArticleCommande, prix, quantité, #idCommande, #idArticle)
COMMANDE(idCommande, date, #idUtilisateur)
FACTURE(idFacture, date, moyenPaiement, #idUtilisateur)
ARTICLE_FACTURE(idArticleFacture, prix, quantité, #idFacture, #idArticleCommande)
"""

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

CREATE TABLE PANIER(
    idPanier INT PRIMARY KEY
);

CREATE TABLE UTILISATEUR(
    idUtilisateur INT PRIMARY KEY,
    prenom VARCHAR(30) NOT NULL,
    nom VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL CHECK (email LIKE '%_@%_.__%'), --Vérifie que l'email est bien de la forme "___@___.___"
    genre VARCHAR(10) NOT NULL,
    tel VARCHAR(10) NOT NULL,
    idPanier INT REFERENCES PANIER(idPanier)
);

CREATE TABLE VENDEUR(
    idVendeur INT PRIMARY KEY,
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
    idEmp INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL CHECK (email LIKE '%_@%_.__%'), --Vérifie que l'email est bien de la forme "___@___.___"
    num_tel VARCHAR(20) NOT NULL,
    genre VARCHAR(10) NOT NULL,
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
    idVendeur INT REFERENCES VENDEUR(idVendeur),
    idCategorie INT REFERENCES CATEGORIE(idCategorie)
);

CREATE TABLE SOUHAIT(
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE UT_POSSEDE_ADRESSE(
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur),
    idAdresse INT REFERENCES ADRESSE(idAdresse)
);

CREATE TABLE NOTE(
    idNote INT PRIMARY KEY,
    score INT NOT NULL,
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur),
    idArticle INT REFERENCES ARTICLE(idArticle)
);

CREATE TABLE COMMENTAIRE(
    idCom INT PRIMARY KEY,
    titre VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL,
    datecommentaire date NOT NULL,
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur),
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
    idVendeur INT REFERENCES VENDEUR(idVendeur)
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
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur)
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
    idEmp INT REFERENCES EMPLOYE(idEmp),
    idAdresse INT REFERENCES ADRESSE(idAdresse)
);

CREATE TABLE ARTICLE_LIVRAISON(
    idArticleLivraison INT PRIMARY KEY,
    prix INT NOT NULL,
    quantité INT NOT NULL,
    idLivraison INT REFERENCES LIVRAISON(idLivraison),
    idArticleCommande INT REFERENCES ARTICLE_COMMANDE(idArticleCommande),
    idEmp INT REFERENCES EMPLOYE(idEmp)
);

CREATE TABLE FACTURE(
    idFacture INT PRIMARY KEY,
    datefacture date NOT NULL,
    idUtilisateur INT REFERENCES UTILISATEUR(idUtilisateur),
    idCommande INT REFERENCES COMMANDE(idCommande)
);

CREATE TABLE ARTICLE_FACTURE(
    idArticleFacture INT PRIMARY KEY,
    prix INT NOT NULL,
    quantité INT NOT NULL,
    idFacture INT REFERENCES FACTURE(idFacture),
    idArticleCommande INT REFERENCES ARTICLE_COMMANDE(idArticleCommande)
);

CREATE USER visiteur IDENTIFIED BY azerty;
CREATE ROLE CLIENT;
CREATE ROLE VENDEUR;
CREATE ROLE LIVREUR
CREATE ROLE EMPLOYE;


"""
-visiteur (regarder les articles, lire les commentaires et notes)
-utilisateur (poster, modifier et supprimer,  regarder/modifier profil, consulter/modifier/créer/supprimer un panier, consulter et créer une commande, consulter, créer et supprimer une adresse, créer et supprimer un souhait)
-vendeur (mettre en vente des articles, les modifier, les supprimer, créer promotion, ajouter, modifier, supprimer des images)
- livreur (peuvent regarder les livraisons à effectuer, et modifier le statut des livraisons)
-employé (supprimer des articles et des commentaires et des notes, créer des livraison, accéder aux factures)
"""

--DROITS VENDEUR

CREATE VIEW ARTICLE_VENDEUR AS (SELECT * FROM ARTICLE WHERE idVendeur = VENDEUR)
GRANT INSERT,SELECT,DELETE,UPDATE ON ARTICLE_VENDEUR TO VENDEUR;

CREATE VIEW PROMO_ARTICLE_VENDEUR AS (SELECT * FROM PROMO_APPLIQUE_ARTICLE WHERE idArticle IN ARTICLE_VENDEUR)
GRANT INSERT,SELECT,DELETE,UPDATE ON PROMO_ARTICLE_VENDEUR TO VENDEUR;

CREATE VIEW IMAGE_ARTICLE_VENDEUR AS (SELECT * FROM IMAGE WHERE idArticle IN ARTICLE_VENDEUR)
GRANT INSERT,SELECT,DELETE,UPDATE ON IMAGE_ARTICLE_VENDEUR TO VENDEUR;

--DROITS EMPLOYÉ

GRANT DELETE,UPDATE,SELECT ON ARTICLE TO EMPLOYE;
GRANT DELETE,SELECT ON COMMENTAIRE TO EMPLOYE;
GRANT DELETE,SELECT ON NOTE TO EMPLOYE;



