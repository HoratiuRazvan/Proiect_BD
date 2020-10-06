CREATE TABLE AUTORI(
id_autor NUMBER PRIMARY KEY NOT NULL,
nume_autor VARCHAR2(35) NOT NULL);

CREATE TABLE CATEGORII(
id_categorie NUMBER PRIMARY KEY NOT NULL,
nume_categorie VARCHAR2(50) NOT NULL,
descriere_categorie VARCHAR2(1000)
);

CREATE TABLE ARTICOLE(
id_articol NUMBER PRIMARY KEY NOT NULL,
id_autor NUMBER,
id_categorie NUMBER,
FOREIGN KEY (id_autor) REFERENCES AUTORI(id_autor),
FOREIGN KEY (id_categorie) REFERENCES CATEGORII(id_categorie),
nume_articol VARCHAR(50) NOT NULL,
continut_articol VARCHAR(1000) NOT NULL,
data_articol DATE);

CREATE TABLE CITITORI(
id_cititor NUMBER PRIMARY KEY NOT NULL,
nume VARCHAR(50) NOT NULL,
varsta NUMBER
);

CREATE TABLE CITITORI_CITESC_ARTICOLE(
id_articol NUMBER,
id_cititor NUMBER,
PRIMARY KEY(id_articol, id_cititor),
FOREIGN KEY(id_articol) REFERENCES ARTICOLE(id_articol),
FOREIGN KEY(id_cititor) REFERENCES CITITORI(id_cititor)
);

CREATE TABLE COMENTARII(
id_comentariu NUMBER PRIMARY KEY NOT  NULL,
id_articol NUMBER,
id_cititor NUMBER,
FOREIGN KEY (id_articol) REFERENCES ARTICOLE(id_articol),
FOREIGN KEY (id_cititor) REFERENCES CITITORI(id_cititor),
continut_comentariu VARCHAR(1000) NOT NULL,
data_comentariu DATE);

CREATE TABLE NOTE(
id_nota NUMBER PRIMARY KEY NOT NULL,
id_cititor NUMBER,
id_articol NUMBER,
FOREIGN KEY(id_cititor) REFERENCES CITITORI(id_cititor),
FOREIGN KEY(id_articol) REFERENCES ARTICOLE(id_articol),
val NUMBER
);

INSERT INTO AUTORI VALUES(1,'Popescu Ion');
INSERT INTO AUTORI VALUES(2,'Georgescu Maria');
INSERT INTO AUTORI VALUES(3,'Antonescu Paul');
INSERT INTO AUTORI VALUES(4,'Stanescu Ana');
INSERT INTO AUTORI VALUES(5,'Petrescu Violeta');

INSERT INTO CATEGORII VALUES(1,'Informatica','Termenul informatic? desemneaz? ?tiin?a proces?rii sistematice a informa?iei, în special a proces?rii cu ajutorul calculatoarelor. Termenul englezesc corespunz?tor este Computer Science (?tiin?a calculatoarelor).Istoric, informatica s-a dezvoltat ca ?tiin?? din matematic?, în timp ce dezvoltarea primelor calculatoare î?i are originea în electrotehnic? ?i telecomunica?ii. De aceea, calculatorul reprezint? doar dispozitivul pe care sunt implementate conceptele teoretice. Informaticianul olandez Edsger Dijkstra afirma: "În informatic? ai de-a face cu calculatorul, a?a cum ai în astronomie cu telescopul".A nu se confunda informatica nici cu Tehnologia informa?iei ?i nici cu teoria informa?iei.');
INSERT INTO CATEGORII VALUES(2,'Fizica', 'Fizica este ?tiin?a care studiaz? propriet??ile ?i structura materiei, formele de mi?care ale acesteia, precum ?i transform?rile lor reciproce. Fizica este una dintre cele mai fundamentale discipline ?tiin?ifice, iar scopul s?u principal este de a în?elege cum se comport? universul.');
INSERT INTO CATEGORII VALUES(3,'Literatura', 'Literatura este arta compozi?iilor scrise. O traducere literal? a termenului indic? sensul de "cunoa?tere cu ajutorul literelor" (de la latinescul littera, liter?), iar studiul academic al literaturii este cunoscut ca Litere.');
INSERT INTO CATEGORII VALUES(4,'Sociologie','Sociologia este ?tiin?a social? ce studiaz? regulile sociale ?i procesele care leag? ?i separ? oamenii, nu numai ca indivizi dar ?i ca membri ai asocia?iilor, grupurilor ?i institu?iilor. Termenul a fost propus de c?tre Auguste Comte.');
INSERT INTO CATEGORII VALUES(5,'Filosofie', 'Filozofia este o modalitate de gândire ?i investigare, format? dintr-un ansamblu de no?iuni ?i idei, care tinde s? cunoasc? ?i s? în?eleag? sensul existen?ei sub aspectele sale cele mai generale, o concep?ie general? despre lume ?i via??.');

INSERT INTO ARTICOLE VALUES(1,1,1,'Algoritmul lui Dijkstra','Algoritmul lui Dijkstra este o metod? de a stabili drumul de cost minim de la un nod de start la oricare altul dintr-un graf. Numele este dat de Edsger Dijkstra, savantul care l-a descoperit.',TO_DATE('13/12/2019','DD/MM/YYYY'));
INSERT INTO ARTICOLE VALUES(2,2,3,'Crima ?i pedeapsa','Crima ?i pedeapsa este un roman scris de autorul rus Fiodor Dostoevski, fiind publicat pentru prima data în ziarul intitulat „Mesagerul rus”, ap?rând în 12 numere lunare ca mai tarziu sa fie publicat ca roman, fiind considerat una dintre cele mai cunoscute opere literare a tuturor timpurilor, cu influente asupra romancierilor ce i-au urmat.',TO_DATE('12/01/2020','DD/MM/YYYY'));
INSERT INTO ARTICOLE VALUES(3,1,1,'Algoritmul lui Euclid','Algoritmul lui Euclid calculeaz? eficient CMMDC a dou? numere oricât de mari sunt, deoarece nu necesit? niciodat? un num?r de pa?i mai mare decât de cinci ori num?rul de cifre (în baz? 10) al celui mai mic întreg.',TO_DATE('13/12/2019','DD/MM/YYYY'));
INSERT INTO ARTICOLE VALUES(4,4,1,'Algoritmul lui Kruskal','Algoritmul lui Kruskal este un algoritm în teoria grafurilor care g?se?te arborele par?ial de cost minim pentru un graf conex ponderat. Cu alte cuvinte, g?se?te submul?imea muchiilor care formeaz? un arbore care include toate vârfurile ?i care este minimizat din punct de vedere al costului. Dac? graful nu este conex, atunci algoritmul g?se?te o p?dure par?ial? de cost minim (un arbore par?ial de cost minim pentru fiecare component? conex?). Algoritmul lui Kruskal este un exemplu de algoritm greedy.',TO_DATE('02/02/2020','DD/MM/YYYY'));
INSERT INTO ARTICOLE VALUES(5,5,5,'Immanuel Kant','Într-una din lucr?rile majore ale lui Kant, Critica ra?iunii pure (1781),[13] el a încercat s? explice rela?ia dintre ra?iune ?i experien?a uman? ?i s? mearg? dincolo de e?ecurile filozofiei ?i metafizicii tradi?ionale. Kant a vrut s? pun? cap?t unei epoci a teoriilor inutile ?i speculative ale experien?ei umane, rezistând în acela?i timp scepticismului gânditorilor precum David Hume.',TO_DATE('13/12/2019','DD/MM/YYYY'));

INSERT INTO CITITORI VALUES(1,'Andrei',23);
INSERT INTO CITITORI VALUES(2,'Sebastian',56);
INSERT INTO CITITORI VALUES(3,'Ana',23);
INSERT INTO CITITORI VALUES(4,'Ioana',23);
INSERT INTO CITITORI VALUES(5,'Costel',21);

INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(1,1);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(1,2);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(1,3);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(2,1);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(2,4);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(2,5);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(3,1);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(4,1);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(5,1);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(4,4);
INSERT INTO CITITORI_CITESC_ARTICOLE VALUES(5,5);

INSERT INTO COMENTARII VALUES(1,1,1,'Foarte frumos, felicitari!',TO_DATE('02/02/2020','DD/MM/YYYY'));
INSERT INTO COMENTARII VALUES(2,1,2,'Imi place, dar nu sunt chiar de acord',TO_DATE('06/06/2020','DD/MM/YYYY'));
INSERT INTO COMENTARII VALUES(3,4,2,'Nu prea apreciez, dar continuati treaba',TO_DATE('09/03/2020','DD/MM/YYYY'));
INSERT INTO COMENTARII VALUES(4,1,4,'E OK',TO_DATE('01/01/2020','DD/MM/YYYY'));
INSERT INTO COMENTARII VALUES(5,5,5,'Imi place mult, continuati treaba!',TO_DATE('25/02/2020','DD/MM/YYYY'));
INSERT INTO COMENTARII VALUES(6,4,4,'Asteptam de mult articolul',TO_DATE('12/02/2020','DD/MM/YYYY'));

INSERT INTO NOTE VALUES(1,1,1,10);
INSERT INTO NOTE VALUES(2,1,2,6);
INSERT INTO NOTE VALUES(3,5,5, 10);
INSERT INTO NOTE VALUES(4,1,4,4);
INSERT INTO NOTE VALUES(5,4,2,2);

SELECT * FROM CITITORI;