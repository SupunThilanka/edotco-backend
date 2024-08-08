PGDMP  6    "                |            Edotco    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17012    Edotco    DATABASE     �   CREATE DATABASE "Edotco" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Edotco";
                postgres    false            �           0    0    DATABASE "Edotco"    ACL     ,   GRANT ALL ON DATABASE "Edotco" TO "Edotco";
                   postgres    false    4816            �            1259    17092 	   equipment    TABLE     �   CREATE TABLE public.equipment (
    equipment_id integer NOT NULL,
    image_location character varying(255),
    name character varying,
    description character varying(2000)
);
    DROP TABLE public.equipment;
       public         heap    postgres    false            �            1259    17091    equipment_equipment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.equipment_equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.equipment_equipment_id_seq;
       public          postgres    false    221            �           0    0    equipment_equipment_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.equipment_equipment_id_seq OWNED BY public.equipment.equipment_id;
          public          postgres    false    220            �            1259    17058    tower_created    TABLE     �   CREATE TABLE public.tower_created (
    creation_id integer NOT NULL,
    latitude character varying(100),
    longitude character varying(100),
    tower_id integer
);
 !   DROP TABLE public.tower_created;
       public         heap    postgres    false            �            1259    17057    tower_created_tower_id_seq    SEQUENCE     �   ALTER TABLE public.tower_created ALTER COLUMN creation_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tower_created_tower_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    17075    tower_equipment    TABLE     m   CREATE TABLE public.tower_equipment (
    creation_id integer NOT NULL,
    equipment_id integer NOT NULL
);
 #   DROP TABLE public.tower_equipment;
       public         heap    postgres    false            �            1259    17051 
   tower_type    TABLE     �   CREATE TABLE public.tower_type (
    tower_id integer NOT NULL,
    name character varying(100) NOT NULL,
    image_location character varying(100),
    description character varying(2000)
);
    DROP TABLE public.tower_type;
       public         heap    postgres    false            �            1259    17050    tower_type_tower_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tower_type_tower_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.tower_type_tower_id_seq;
       public          postgres    false    216            �           0    0    tower_type_tower_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.tower_type_tower_id_seq OWNED BY public.tower_type.tower_id;
          public          postgres    false    215            )           2604    17095    equipment equipment_id    DEFAULT     �   ALTER TABLE ONLY public.equipment ALTER COLUMN equipment_id SET DEFAULT nextval('public.equipment_equipment_id_seq'::regclass);
 E   ALTER TABLE public.equipment ALTER COLUMN equipment_id DROP DEFAULT;
       public          postgres    false    221    220    221            (           2604    17054    tower_type tower_id    DEFAULT     z   ALTER TABLE ONLY public.tower_type ALTER COLUMN tower_id SET DEFAULT nextval('public.tower_type_tower_id_seq'::regclass);
 B   ALTER TABLE public.tower_type ALTER COLUMN tower_id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    17092 	   equipment 
   TABLE DATA           T   COPY public.equipment (equipment_id, image_location, name, description) FROM stdin;
    public          postgres    false    221   �"       �          0    17058    tower_created 
   TABLE DATA           S   COPY public.tower_created (creation_id, latitude, longitude, tower_id) FROM stdin;
    public          postgres    false    218   R%       �          0    17075    tower_equipment 
   TABLE DATA           D   COPY public.tower_equipment (creation_id, equipment_id) FROM stdin;
    public          postgres    false    219   �%       �          0    17051 
   tower_type 
   TABLE DATA           Q   COPY public.tower_type (tower_id, name, image_location, description) FROM stdin;
    public          postgres    false    216   �%       �           0    0    equipment_equipment_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.equipment_equipment_id_seq', 10, true);
          public          postgres    false    220            �           0    0    tower_created_tower_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tower_created_tower_id_seq', 3, true);
          public          postgres    false    217            �           0    0    tower_type_tower_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tower_type_tower_id_seq', 10, true);
          public          postgres    false    215            /           2606    17111    tower_equipment combine_key 
   CONSTRAINT     p   ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT combine_key PRIMARY KEY (creation_id, equipment_id);
 E   ALTER TABLE ONLY public.tower_equipment DROP CONSTRAINT combine_key;
       public            postgres    false    219    219            1           2606    17097    equipment equipment_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);
 B   ALTER TABLE ONLY public.equipment DROP CONSTRAINT equipment_pkey;
       public            postgres    false    221            -           2606    17062     tower_created tower_created_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.tower_created
    ADD CONSTRAINT tower_created_pkey PRIMARY KEY (creation_id);
 J   ALTER TABLE ONLY public.tower_created DROP CONSTRAINT tower_created_pkey;
       public            postgres    false    218            +           2606    17056    tower_type tower_type_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tower_type
    ADD CONSTRAINT tower_type_pkey PRIMARY KEY (tower_id);
 D   ALTER TABLE ONLY public.tower_type DROP CONSTRAINT tower_type_pkey;
       public            postgres    false    216            2           2606    17105 )   tower_created tower_created_tower_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tower_created
    ADD CONSTRAINT tower_created_tower_id_fkey FOREIGN KEY (tower_id) REFERENCES public.tower_type(tower_id);
 S   ALTER TABLE ONLY public.tower_created DROP CONSTRAINT tower_created_tower_id_fkey;
       public          postgres    false    218    4651    216            3           2606    17098 1   tower_equipment tower_equipment_equipment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT tower_equipment_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id);
 [   ALTER TABLE ONLY public.tower_equipment DROP CONSTRAINT tower_equipment_equipment_id_fkey;
       public          postgres    false    4657    221    219            4           2606    17080 -   tower_equipment tower_equipment_tower_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT tower_equipment_tower_id_fkey FOREIGN KEY (creation_id) REFERENCES public.tower_created(creation_id);
 W   ALTER TABLE ONLY public.tower_equipment DROP CONSTRAINT tower_equipment_tower_id_fkey;
       public          postgres    false    218    4653    219            �   �  x�]SMo�0=˿��H�u�;�k�+��6 �e��"K�D'�~�(�i��$�"�{|<W�1:��A;���Щ�}rDݤ��I[X��K1��@�"�M�%Ꜷ��{?J�������������c�����T�]ꄰ�es!��ȚI��\.OբG0>"��� P
�atdJ�z�b3��[�_l�{|C���T�cA0��3¼|}r�p2�?��;/��C-��$�L.�`̙z�V$�&�°貊~(����	B�$��:����D��\������k	��$02������r�_QY���A�"�InȃX`D�(�����*�ץ�9���!G�jQWޱ&�$B���4�F3c,�̵�f=H��8$!�Ƙ�
4QLd��~���L�2׺����������#LvT�o���x��4L�����5�V�.J	���k�L���%��>�5B�&��[,���(���,�E����,�����r��q&g�'S:����$���O���j�`����z��k�6i-���9�yطpP��s�p���+��٩u�E$K+\�#^���]��Ia:���zC��[qE��_X��wuu�Fu�յ\�i_�����yb,z���69/I��Ji��8%���X��]�؟uUU� 2贔      �   %   x�3�4�NCSNC.#��pq��b���� ة�      �      x�3�4�2�4�2bc06b�=... 4�v      �   �  x�u�ˎ�0E��W�������F0�͆��T'f;�ѭ�{n9NO�U��Uu��u��[g���wd_Me�����=m���&�<�qT�B�g�c e#[��'�z��$=OlcC���j�w��o�%����D�42L��Iqq�a��ꛊQw+�YVj�CD=�Q�>u1y�I�Ln�/̆J������Zw��A
�z%���̭Zmt<	Qi��d��A�6��/�/��}a�Ee�ög�T�!�=�=��>u�y�]�ړOo�0Ǒ%pVh^�.�"GR��yY�"+�#,�L�,ʡ�VhP�������2�+����S�K{��rY	8�/� �M�UA����&�:��q���M�������/�w���9���f���I�g��� ��Kh +���M�&iK=�r��ES(��ڱ�ov�蒣($_��k��wm
�fʺ)<�V����BƩ"P�����˛j{wOO�l��{?�iչc)?9xN� �H6.�(���Lܰo�g����<�	�Opā=&��䅜RW�@�������g���~��r5�i^�L�Ԃ�ox���E�0� �
XM�愙�m�>�n�pS��nu�]'͗�ʺ.u;7A�X�Ik�s!���f�_(���l�$Z`k1@��	�˗XÏ2��IM}�����G���ĸ�f�o�A6^�a�K.&��i��zd�z�ɃF����8�*�j��1��     