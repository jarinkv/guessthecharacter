<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" xmlns:jarinkv="https://jarinkv.github.io/guessthecharacter/nohtml">
	<xsl:output method="html" html-version="5.0" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" lang="ru">
			<head>
				<meta charset="utf-8"/>
				<title>Угадай персонажа! (подкаст)</title>
				<link rel="alternate" type="application/rss+xml" title="Угадай персонажа!" href="https://jarinkv.github.io/guessthecharacter/podcastfeed.xml"/>
				<link rel="icon" href="favicon.svg" />
				<meta name="viewport" content="width=device-width" />
				<link rel="stylesheet" type="text/css" href="podcastcss.css"/>
			</head>
			<body>
				<header>
					<nav>
						<ul>
							<li>
								<a href="https://t.me/literaturna">ЛИТЕРАТУРНАЯ</a>
							</li>
							<li>
								<a href="https://t.me/neujeliatut">Анна Гвоздь</a>
							</li>
							<li>
								<a href="https://t.me/literaturna/491">Поддержать деньгами</a>
							</li>
						</ul>
					</nav>
				</header>
				<main>
					<h1><xsl:value-of select="/rss/channel/title"/></h1>
					<div class="textwithphoto">
						<img class="photo">
							<xsl:attribute name="src">art/anna_with_book.jpg</xsl:attribute>
							<xsl:attribute name="alt">Анна Гвоздь с книгой пристально смотрит на тебя</xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="/rss/channel/description"/></xsl:attribute>
						</img>
						<p><xsl:value-of select="/rss/channel/description"/></p>
						<p>Подкаст является частью проекта Книжный, и все выпуски также публикуются в <a href="https://t.me/literaturna">ЛИТЕРАТУРНОЙ</a> под тэгом #интервью_персонаж.</p>
						<p>Внизу страницы есть <a href="#wheretolisten">список платформ и каталогов для подкастов</a>, где мы уже точно есть.</p>
						<p>Эта страница является <a class="url"><xsl:attribute name="href"><xsl:value-of select="/rss/channel/atom:link/@href"/></xsl:attribute>прямой RSS</a>, которую можно добавить в приложение для подкастов.</p>
						<p><a class="button" href="pcast://jarinkv.github.io/guessthecharacter/podcastfeed.xml">Открой в приложении для подкастов</a></p>
					</div>
					<h2>Список эпизодов</h2>
					<ul class="episodes">
						<xsl:for-each select="/rss/channel/item">
						<li>
							<h3>
								<xsl:attribute name="id"><xsl:value-of select="guid"/></xsl:attribute>
								<xsl:value-of select="title"/>
							</h3>
							<p>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="link"/>
									</xsl:attribute>
									Пост в Литературной
								</a>
							</p>
							<div class="details">
								<p>
									<xsl:choose>
										<xsl:when test="jarinkv:nohtml">
											<xsl:value-of select="jarinkv:nohtml"/>
											<xsl:if test="jarinkv:spoiler">
												<span class="spoiler" tabindex="0">
													<xsl:value-of select="jarinkv:spoiler"/>
												</span>
											</xsl:if>
											<xsl:if test="jarinkv:morelink">
												<a>
													<xsl:attribute name="href"><xsl:value-of select="jarinkv:morelink/jarinkv:morehref"/></xsl:attribute>
													<xsl:value-of select="jarinkv:morelink/jarinkv:moretext"/>
												</a>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="description" disable-output-escaping="yes"/>
										</xsl:otherwise>
									</xsl:choose>
								</p>
								<xsl:for-each select="jarinkv:suplink">
									<p>💾 <a><xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>Скачать <xsl:value-of select="."/></a></p>
								</xsl:for-each>
							</div>
							<div class="pubdate">
								<p>
									<xsl:variable name="datetime" select="substring-before(substring(pubDate,6),' +')"/>
									<xsl:variable name="dd" select="substring-before($datetime,' ')"/>
									<xsl:variable name="monthyeartime" select="substring-after($datetime,' ')"/>
									<xsl:variable name="month" select="substring-before($monthyeartime,' ')"/>
									<xsl:variable name="yeartime" select="substring-after($monthyeartime,' ')"/>
									<xsl:variable name="year" select="substring-before($yeartime,' ')"/>
									<xsl:variable name="time" select="substring-after($yeartime,' ')"/>
									<xsl:variable name="rusmonth">
										<xsl:choose>
											<xsl:when test="$month='Jan'">января</xsl:when>
											<xsl:when test="$month='Feb'">февраля</xsl:when>
											<xsl:when test="$month='Mar'">марта</xsl:when>
											<xsl:when test="$month='Apr'">апреля</xsl:when>
											<xsl:when test="$month='May'">мая</xsl:when>
											<xsl:when test="$month='Jun'">июня</xsl:when>
											<xsl:when test="$month='Jul'">июля</xsl:when>
											<xsl:when test="$month='Aug'">августа</xsl:when>
											<xsl:when test="$month='Sep'">сентября</xsl:when>
											<xsl:when test="$month='Oct'">октября</xsl:when>
											<xsl:when test="$month='Nov'">ноября</xsl:when>
											<xsl:when test="$month='Dec'">декабря</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$month"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									Эпизод вышел <xsl:value-of select="concat($dd,' ',$rusmonth,' ',$year)"/> в <xsl:value-of select="$time"/>
								</p>
							</div>
							<xsl:if test="enclosure">
								<h4>Скачать этот эпизод:</h4>
								<ul>
									<xsl:for-each select="enclosure">
									<li>
										<p>💾
											<a>
												<xsl:attribute name="href">
													<xsl:value-of select="@url"/>
												</xsl:attribute>
												<xsl:attribute name="download"/>
												<xsl:choose>
													<xsl:when test="contains(@url,'Угадай%20персонажа%20')">
														<xsl:variable name="filenamepostfix" select="substring-after(@url,'Угадай%20персонажа%20')"/>
														<xsl:choose>
															<xsl:when test="contains($filenamepostfix,'%20')">
																Угадай персонажа <xsl:value-of select="concat(substring-before($filenamepostfix,'%20'),' ',substring-after($filenamepostfix,'%20'))"/>
															</xsl:when>
															<xsl:otherwise>
																Угадай персонажа <xsl:value-of select="$filenamepostfix"/>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>
														<xsl:choose>
															<xsl:when test="contains(@url,'The%20Colbert%20Questionert%20Анна%20Гвоздь.m4a')">
																The Colbert Questionert Анна Гвоздь.m4a
															</xsl:when>
															<xsl:when test="contains(@url,'The%20Colbert%20Questionert%20Кирилл%20Ярин.m4a')">
																The Colbert Questionert Кирилл Ярин.m4a
															</xsl:when>
															<xsl:when test="contains(@url,'guessthecharacter/')">
																<xsl:value-of select="substring-after(@url,'guessthecharacter/')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="@url"/>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:otherwise>
												</xsl:choose>
											</a>
										</p>
									</li>
									</xsl:for-each>
								</ul>
							</xsl:if>
						</li>
						</xsl:for-each>
					</ul>
				</main>
				<footer id="wheretolisten">
					<p>Подкаст доступен на следующих приложениях, платформах и каталогах:</p>
					<ul class="podcastapps">
						<li>
							<p>
								<a href="https://podcasts.apple.com/podcast/угадай-персонажа/id1850428486">Apple</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://music.amazon.co.uk/podcasts/2d4d6601-b62b-4e9a-9445-7e52a33bc980/угадай-персонажа">Amazon</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://open.spotify.com/show/2j7W0XHN1S09c3SgE4vRRW">Spotify</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://www.podbean.com/pw/dir-zsh7b-373a9e">Podbean</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://podcastindex.org/podcast/7565998">PodcastIndex</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://castbox.fm/ch/6806986">Castbox</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://www.listennotes.com/podcasts/угадай-персонажа-литературная-NlWHZzmFpSd/">ListenNotes</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://tunein.com/podcasts/Arts--Culture-Podcasts/Угадай-персонажа-p4690078/">TuneIn</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://podcastaddict.com/podcast/УгадайПерсонажа/6168287">PodcastAddict</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://pca.st/j1agxltm">PocketCasts</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://www.podchaser.com/podcasts/ugadai-personaza-6269363">PodChaser</a>
							</p>
						</li>
						<li>
							<p>
								<a href="https://www.youtube.com/playlist?list=PLYY7fey0PJeVi212t_OzIMGhCgYGynilX">YouTube</a>
							</p>
						</li>
					</ul>
				</footer>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
