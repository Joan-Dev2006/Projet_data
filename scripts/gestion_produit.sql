-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : sam. 07 fév. 2026 à 11:22
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_produit`
--

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `alerte_inflation`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `alerte_inflation`;
CREATE TABLE `alerte_inflation` (
`id_produit` int(11)
,`nom` varchar(20)
,`quantite` double
,`prix` int(11)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `catalogue_de_luxe`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `catalogue_de_luxe`;
CREATE TABLE `catalogue_de_luxe` (
`nom` varchar(20)
,`quantite` double
,`prix` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la table `historique_prix`
--

DROP TABLE IF EXISTS `historique_prix`;
CREATE TABLE `historique_prix` (
  `id_historique` int(11) NOT NULL,
  `id_produit` int(11) DEFAULT NULL,
  `ancien_prix` double DEFAULT NULL,
  `nouveau_prix` double DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_prix`
--

INSERT INTO `historique_prix` (`id_historique`, `id_produit`, `ancien_prix`, `nouveau_prix`, `date`) VALUES
(1, 2, 150, 130, NULL),
(2, 3, 80, 75, NULL),
(3, 1, 850, 800, '2026-02-05 19:14:44');

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE `produits` (
  `id_produit` int(11) NOT NULL,
  `nom` varchar(20) DEFAULT NULL,
  `quantite` double DEFAULT NULL,
  `prix` int(11) DEFAULT NULL,
  `date_mise_a_jour` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id_produit`, `nom`, `quantite`, `prix`, `date_mise_a_jour`) VALUES
(1, 'Ordinateur Portable', 10, 800, '2026-02-05 19:04:03'),
(2, 'Écran 24 pouces', 25, 130, '2026-02-05 19:04:03'),
(3, 'Clavier Mécanique', 50, 75, '2026-02-05 19:04:03'),
(4, 'Souris Sans Fil', 100, 25, '2026-02-05 19:04:03');

--
-- Déclencheurs `produits`
--
DROP TRIGGER IF EXISTS `mise_a_jour_prix`;
DELIMITER $$
CREATE TRIGGER `mise_a_jour_prix` AFTER UPDATE ON `produits` FOR EACH ROW BEGIN
INSERT INTO historique_prix (id_produit, ancien_prix, nouveau_prix,date)
        VALUES (OLD.id_produit, OLD.prix, NEW.prix,NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `synthèse_hebdomadaire`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `synthèse_hebdomadaire`;
CREATE TABLE `synthèse_hebdomadaire` (
`COUNT(*)` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure de la vue `alerte_inflation`
--
DROP TABLE IF EXISTS `alerte_inflation`;

DROP VIEW IF EXISTS `alerte_inflation`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alerte_inflation`  AS SELECT `p`.`id_produit` AS `id_produit`, `p`.`nom` AS `nom`, `p`.`quantite` AS `quantite`, `p`.`prix` AS `prix` FROM (`produits` `p` join `historique_prix` `h` on(`h`.`id_produit` = `p`.`id_produit`)) WHERE `p`.`prix` * 1.10 > `h`.`ancien_prix` ;

-- --------------------------------------------------------

--
-- Structure de la vue `catalogue_de_luxe`
--
DROP TABLE IF EXISTS `catalogue_de_luxe`;

DROP VIEW IF EXISTS `catalogue_de_luxe`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `catalogue_de_luxe`  AS SELECT `produits`.`nom` AS `nom`, `produits`.`quantite` AS `quantite`, `produits`.`prix` AS `prix` FROM `produits` WHERE `produits`.`prix` > 500 ORDER BY `produits`.`prix` DESC ;

-- --------------------------------------------------------

--
-- Structure de la vue `synthèse_hebdomadaire`
--
DROP TABLE IF EXISTS `synthèse_hebdomadaire`;

DROP VIEW IF EXISTS `synthèse_hebdomadaire`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `synthèse_hebdomadaire`  AS SELECT count(0) AS `COUNT(*)` FROM (`produits` `p` join `historique_prix` `h` on(`h`.`id_produit` = `p`.`id_produit`)) WHERE `p`.`prix` <> `h`.`ancien_prix` AND `p`.`date_mise_a_jour` > current_timestamp() - interval 7 day ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `historique_prix`
--
ALTER TABLE `historique_prix`
  ADD PRIMARY KEY (`id_historique`),
  ADD KEY `fk_historique_produits` (`id_produit`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id_produit`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `historique_prix`
--
ALTER TABLE `historique_prix`
  MODIFY `id_historique` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `historique_prix`
--
ALTER TABLE `historique_prix`
  ADD CONSTRAINT `fk_historique_produits` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
