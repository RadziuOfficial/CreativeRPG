-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 94.23.90.14:3306
-- Czas generowania: 03 Maj 2018, 08:05
-- Wersja serwera: 5.5.54-0+deb8u1-log
-- Wersja PHP: 7.1.12-2+0~20171207160618.12+stretch~1.gbp5c91f3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `db_31727`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Autostart`
--

CREATE TABLE `Autostart` (
  `skrypt` varchar(64) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Autostart`
--

INSERT INTO `Autostart` (`skrypt`) VALUES
('Animacje'),
('cbradio'),
('crpg_bankomaty'),
('crpg_doherty'),
('crpg_gielda_sf'),
('crpg_interakcja'),
('crpg_logowanie'),
('crpg_mechanik'),
('crpg_muzyka'),
('crpg_new_mechanic'),
('crpg_new_salon'),
('crpg_panelGracza'),
('crpg_playerBlips'),
('crpg_powiadomienia'),
('crpg_prawko_mapa'),
('crpg_przebieralnia'),
('crpg_przewodnik'),
('crpg_publiczne'),
('crpg_radar'),
('crpg_radio'),
('crpg_salon'),
('crpg_scoreboard'),
('crpg_stacje'),
('crpg_tempomat'),
('crpg_tuner_garcia'),
('crpg-int_magazynier'),
('crpg-interior_magazyn'),
('crpg-interior_przebieralnia'),
('crpg-job_autobusy'),
('crpg-job_holownik'),
('crpg-job_kosiarki'),
('crpg-job_magazynier'),
('crpg-job_ustawienia'),
('crpg-map_gieldaLV'),
('crpg-map_mechanik'),
('crpg-map_osiedle'),
('crpg-map_parkingPrzebieralnia'),
('crpg-map_przechowywalnia'),
('crpg-map_salon'),
('crpg-map_salonV2'),
('crpg-map_spawn'),
('crpg-map_spawnLV'),
('crpg-map_zajezdnia'),
('crpg-model_banner'),
('crpg-model_felgi'),
('crpg-model_mechanik'),
('crpg-model_parking'),
('crpg-model_prawko'),
('crpg-model_ratusz'),
('CRPG-Slupki'),
('CRPG-textures'),
('dxedits'),
('fotoradary'),
('jailsapd'),
('kajdanki'),
('kasyno'),
('mysql'),
('nm-admin'),
('nm-afk'),
('nm-blur'),
('nm-core'),
('nm-domy'),
('nm-gielda'),
('nm-gpojazdy'),
('nm-gui'),
('nm-iadmin'),
('nm-lakiernia1'),
('nm-logi'),
('nm-login'),
('nm-organizacje'),
('nm-pojazdy'),
('nm-pomoc'),
('nm-przebieralnia'),
('nm-sorg'),
('nm-sprzedaz'),
('nm-teleporty'),
('nm-tuning'),
('nm-tuningm'),
('Prawko'),
('przechowalnia'),
('Replace_Dockbar'),
('stereo');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bany`
--

CREATE TABLE `bany` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2,
  `serial` text CHARACTER SET latin2,
  `ip` text CHARACTER SET latin2,
  `data` text CHARACTER SET latin7,
  `admin` text CHARACTER SET latin2
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `domy`
--

CREATE TABLE `domy` (
  `id` int(11) NOT NULL,
  `wlasciciel` int(11) DEFAULT NULL,
  `nwlasciciel` text CHARACTER SET latin7,
  `nazwa` text CHARACTER SET latin7 NOT NULL,
  `data` date NOT NULL,
  `wejscie` text CHARACTER SET latin7 NOT NULL,
  `wyjscie` text CHARACTER SET latin7 NOT NULL,
  `tpw` text CHARACTER SET latin7 NOT NULL,
  `int` int(11) NOT NULL DEFAULT '8',
  `cena` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ekipa`
--

CREATE TABLE `ekipa` (
  `id` int(11) NOT NULL,
  `gracz` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `serial` text CHARACTER SET latin2 NOT NULL,
  `ranga` text CHARACTER SET latin2 NOT NULL,
  `tranga` int(11) NOT NULL,
  `hex` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Neveron';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `frakcje`
--

CREATE TABLE `frakcje` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `nick` text CHARACTER SET utf8 NOT NULL,
  `frakcja` text CHARACTER SET utf8 NOT NULL,
  `rank` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `jail`
--

CREATE TABLE `jail` (
  `id` int(11) NOT NULL,
  `Serial` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `Termin` date NOT NULL,
  `Cela` int(11) NOT NULL DEFAULT '0',
  `Powod` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `konta`
--

CREATE TABLE `konta` (
  `dbid` int(11) NOT NULL,
  `login` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `haslo` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `kasa` float NOT NULL,
  `punkty` int(11) NOT NULL DEFAULT '0',
  `bkasa` float NOT NULL,
  `premium` date NOT NULL,
  `rejestracja` date NOT NULL,
  `serial` text CHARACTER SET latin7 NOT NULL,
  `skin` int(11) NOT NULL DEFAULT '0',
  `prawko_a` int(11) NOT NULL,
  `prawko_b` int(11) NOT NULL,
  `prawko_c` int(11) NOT NULL,
  `prawko_l` int(11) NOT NULL,
  `urzedowka` text NOT NULL,
  `online` text CHARACTER SET latin7 NOT NULL,
  `mlvl` int(11) NOT NULL DEFAULT '1',
  `mexp` int(25) NOT NULL,
  `org` int(11) NOT NULL DEFAULT '0',
  `oranga` int(11) NOT NULL DEFAULT '1',
  `pos` text CHARACTER SET latin2,
  `wyplata` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Neveron';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logi`
--

CREATE TABLE `logi` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2 NOT NULL,
  `tresc` text CHARACTER SET latin7 NOT NULL,
  `serial` text CHARACTER SET latin2 NOT NULL,
  `data` text CHARACTER SET latin2,
  `typ` text CHARACTER SET latin2 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `organizacje`
--

CREATE TABLE `organizacje` (
  `id` int(11) NOT NULL,
  `nazwa` text CHARACTER SET latin2 NOT NULL,
  `r1` text CHARACTER SET latin2 NOT NULL,
  `r2` text CHARACTER SET latin2 NOT NULL,
  `r3` text CHARACTER SET latin2 NOT NULL,
  `r4` text CHARACTER SET latin2 NOT NULL,
  `r5` text CHARACTER SET latin2 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pojazdy`
--

CREATE TABLE `pojazdy` (
  `pojemnosc` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `wlasciciel` int(11) NOT NULL,
  `przechowalnia` int(11) NOT NULL,
  `kolor` text CHARACTER SET latin7 NOT NULL,
  `przebieg` int(11) NOT NULL DEFAULT '0',
  `paliwo` int(11) NOT NULL DEFAULT '0',
  `rejestracja` text CHARACTER SET latin2 NOT NULL,
  `bak` int(11) NOT NULL DEFAULT '50',
  `tuning` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `organizacja` text CHARACTER SET latin2 NOT NULL,
  `zawieszenie` int(1) NOT NULL DEFAULT '0',
  `mk1` int(11) NOT NULL,
  `mk2` int(11) NOT NULL,
  `mk3` int(11) NOT NULL,
  `naped` text CHARACTER SET latin2 NOT NULL,
  `panelstates` text CHARACTER SET latin7 NOT NULL,
  `zdrowie` int(11) NOT NULL DEFAULT '1000',
  `licznik` text CHARACTER SET latin2 NOT NULL,
  `swiatla` text CHARACTER SET latin2 NOT NULL,
  `pozycja` text CHARACTER SET latin7 NOT NULL,
  `cb` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `prawka`
--

CREATE TABLE `prawka` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2,
  `serial` text CHARACTER SET latin2,
  `ip` text CHARACTER SET latin2,
  `data` text CHARACTER SET latin7,
  `admin` text CHARACTER SET latin2
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `Autostart`
--
ALTER TABLE `Autostart`
  ADD PRIMARY KEY (`skrypt`);

--
-- Indexes for table `bany`
--
ALTER TABLE `bany`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `domy`
--
ALTER TABLE `domy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ekipa`
--
ALTER TABLE `ekipa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frakcje`
--
ALTER TABLE `frakcje`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jail`
--
ALTER TABLE `jail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `konta`
--
ALTER TABLE `konta`
  ADD PRIMARY KEY (`dbid`);

--
-- Indexes for table `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organizacje`
--
ALTER TABLE `organizacje`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pojazdy`
--
ALTER TABLE `pojazdy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prawka`
--
ALTER TABLE `prawka`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `bany`
--
ALTER TABLE `bany`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `domy`
--
ALTER TABLE `domy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `ekipa`
--
ALTER TABLE `ekipa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `frakcje`
--
ALTER TABLE `frakcje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `jail`
--
ALTER TABLE `jail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `konta`
--
ALTER TABLE `konta`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `logi`
--
ALTER TABLE `logi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `organizacje`
--
ALTER TABLE `organizacje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `pojazdy`
--
ALTER TABLE `pojazdy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `prawka`
--
ALTER TABLE `prawka`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
