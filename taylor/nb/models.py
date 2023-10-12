# coding: utf-8
# generated with: `sqlacodegen postgresql://taylor:postgres@localhost:5432/courtlistener > models.py`

from sqlalchemy import BigInteger, Boolean, CheckConstraint, Column, Date, DateTime, Float, ForeignKey, Index, Integer, SmallInteger, String, Table, Text, Time, UniqueConstraint, text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class AudioAudioevent(Base):
    __tablename__ = 'audio_audioevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('audio_audioevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    source = Column(String(10), nullable=False)
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    judges = Column(Text)
    sha1 = Column(String(40), nullable=False)
    download_url = Column(String(500))
    local_path_mp3 = Column(String(100), nullable=False)
    local_path_original_file = Column(String(100), nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)
    duration = Column(SmallInteger)
    processing_complete = Column(Boolean, nullable=False)
    date_blocked = Column(Date)
    blocked = Column(Boolean, nullable=False)
    stt_status = Column(SmallInteger, nullable=False)
    stt_google_response = Column(Text, nullable=False)
    docket_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class AudioAudiopanelevent(Base):
    __tablename__ = 'audio_audiopanelevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('audio_audiopanelevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    audio_id = Column(Integer, nullable=False, index=True)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)


class PeopleDbAbaratingevent(Base):
    __tablename__ = 'people_db_abaratingevent'
    __table_args__ = (
        CheckConstraint('year_rated >= 0'),
    )

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_abaratingevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    year_rated = Column(SmallInteger)
    rating = Column(String(5), nullable=False)
    person_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbAttorney(Base):
    __tablename__ = 'people_db_attorney'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_attorney_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    name = Column(Text, nullable=False, index=True)
    contact_raw = Column(Text, nullable=False)
    phone = Column(String(20), nullable=False)
    fax = Column(String(20), nullable=False)
    email = Column(String(254), nullable=False)


class PeopleDbAttorneyorganization(Base):
    __tablename__ = 'people_db_attorneyorganization'
    __table_args__ = (
        UniqueConstraint('name', 'address1', 'address2', 'city', 'state', 'zip_code'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_attorneyorganization_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    lookup_key = Column(Text, nullable=False, unique=True)
    name = Column(Text, nullable=False, index=True)
    address1 = Column(Text, nullable=False, index=True)
    address2 = Column(Text, nullable=False, index=True)
    city = Column(Text, nullable=False, index=True)
    state = Column(String(2), nullable=False, index=True)
    zip_code = Column(String(10), nullable=False, index=True)


class PeopleDbEducationevent(Base):
    __tablename__ = 'people_db_educationevent'
    __table_args__ = (
        CheckConstraint('degree_year >= 0'),
    )

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_educationevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    degree_level = Column(String(4), nullable=False)
    degree_detail = Column(String(100), nullable=False)
    degree_year = Column(SmallInteger)
    person_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    school_id = Column(Integer, nullable=False, index=True)


class PeopleDbParty(Base):
    __tablename__ = 'people_db_party'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_party_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    name = Column(Text, nullable=False, index=True)
    extra_info = Column(Text, nullable=False, index=True)


class PeopleDbPerson(Base):
    __tablename__ = 'people_db_person'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_person_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    fjc_id = Column(Integer, unique=True)
    slug = Column(String(158), nullable=False, index=True)
    name_first = Column(String(50), nullable=False)
    name_middle = Column(String(50), nullable=False)
    name_last = Column(String(50), nullable=False, index=True)
    name_suffix = Column(String(5), nullable=False)
    date_dob = Column(Date)
    date_granularity_dob = Column(String(15), nullable=False)
    date_dod = Column(Date)
    date_granularity_dod = Column(String(15), nullable=False)
    dob_city = Column(String(50), nullable=False)
    dob_state = Column(String(2), nullable=False)
    dod_city = Column(String(50), nullable=False)
    dod_state = Column(String(2), nullable=False)
    gender = Column(String(2), nullable=False)
    is_alias_of_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    religion = Column(String(30), nullable=False)
    has_photo = Column(Boolean, nullable=False)
    ftm_total_received = Column(Float(53), index=True)
    ftm_eid = Column(String(30))
    date_completed = Column(DateTime(True))
    dob_country = Column(String(50), nullable=False)
    dod_country = Column(String(50), nullable=False)

    is_alias_of = relationship('PeopleDbPerson', remote_side=[id])


class PeopleDbPersonevent(Base):
    __tablename__ = 'people_db_personevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_personevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    date_completed = Column(DateTime(True))
    fjc_id = Column(Integer)
    slug = Column(String(158), nullable=False)
    name_first = Column(String(50), nullable=False)
    name_middle = Column(String(50), nullable=False)
    name_last = Column(String(50), nullable=False)
    name_suffix = Column(String(5), nullable=False)
    date_dob = Column(Date)
    date_granularity_dob = Column(String(15), nullable=False)
    date_dod = Column(Date)
    date_granularity_dod = Column(String(15), nullable=False)
    dob_city = Column(String(50), nullable=False)
    dob_state = Column(String(2), nullable=False)
    dob_country = Column(String(50), nullable=False)
    dod_city = Column(String(50), nullable=False)
    dod_state = Column(String(2), nullable=False)
    dod_country = Column(String(50), nullable=False)
    gender = Column(String(2), nullable=False)
    religion = Column(String(30), nullable=False)
    ftm_total_received = Column(Float(53))
    ftm_eid = Column(String(30))
    has_photo = Column(Boolean, nullable=False)
    is_alias_of_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbPersonraceevent(Base):
    __tablename__ = 'people_db_personraceevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_personraceevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    race_id = Column(Integer, nullable=False, index=True)


class PeopleDbPoliticalaffiliationevent(Base):
    __tablename__ = 'people_db_politicalaffiliationevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_politicalaffiliationevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    political_party = Column(String(5), nullable=False)
    source = Column(String(5), nullable=False)
    date_start = Column(Date)
    date_granularity_start = Column(String(15), nullable=False)
    date_end = Column(Date)
    date_granularity_end = Column(String(15), nullable=False)
    person_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbPositionevent(Base):
    __tablename__ = 'people_db_positionevent'
    __table_args__ = (
        CheckConstraint('votes_no >= 0'),
        CheckConstraint('votes_yes >= 0')
    )

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_positionevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    position_type = Column(String(20))
    job_title = Column(String(100), nullable=False)
    sector = Column(SmallInteger)
    organization_name = Column(String(120))
    location_city = Column(String(50), nullable=False)
    location_state = Column(String(2), nullable=False)
    date_nominated = Column(Date)
    date_elected = Column(Date)
    date_recess_appointment = Column(Date)
    date_referred_to_judicial_committee = Column(Date)
    date_judicial_committee_action = Column(Date)
    judicial_committee_action = Column(String(20), nullable=False)
    date_hearing = Column(Date)
    date_confirmation = Column(Date)
    date_start = Column(Date)
    date_granularity_start = Column(String(15), nullable=False)
    date_termination = Column(Date)
    termination_reason = Column(String(25), nullable=False)
    date_granularity_termination = Column(String(15), nullable=False)
    date_retirement = Column(Date)
    nomination_process = Column(String(20), nullable=False)
    vote_type = Column(String(2), nullable=False)
    voice_vote = Column(Boolean)
    votes_yes = Column(Integer)
    votes_no = Column(Integer)
    votes_yes_percent = Column(Float(53))
    votes_no_percent = Column(Float(53))
    how_selected = Column(String(20), nullable=False)
    has_inferred_values = Column(Boolean, nullable=False)
    appointer_id = Column(Integer, index=True)
    court_id = Column(String(15), index=True)
    person_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    predecessor_id = Column(Integer, index=True)
    school_id = Column(Integer, index=True)
    supervisor_id = Column(Integer, index=True)


class PeopleDbRace(Base):
    __tablename__ = 'people_db_race'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_race_id_seq'::regclass)"))
    race = Column(String(5), nullable=False, unique=True)


class PeopleDbRaceevent(Base):
    __tablename__ = 'people_db_raceevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_raceevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    race = Column(String(5), nullable=False)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbRetentioneventevent(Base):
    __tablename__ = 'people_db_retentioneventevent'
    __table_args__ = (
        CheckConstraint('votes_no >= 0'),
        CheckConstraint('votes_yes >= 0')
    )

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_retentioneventevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    retention_type = Column(String(10), nullable=False)
    date_retention = Column(Date, nullable=False)
    votes_yes = Column(Integer)
    votes_no = Column(Integer)
    votes_yes_percent = Column(Float(53))
    votes_no_percent = Column(Float(53))
    unopposed = Column(Boolean)
    won = Column(Boolean)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    position_id = Column(Integer, index=True)


class PeopleDbSchool(Base):
    __tablename__ = 'people_db_school'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_school_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    name = Column(String(120), nullable=False, index=True)
    ein = Column(Integer, index=True)
    is_alias_of_id = Column(ForeignKey('people_db_school.id', deferrable=True, initially='DEFERRED'), index=True)

    is_alias_of = relationship('PeopleDbSchool', remote_side=[id])


class PeopleDbSchoolevent(Base):
    __tablename__ = 'people_db_schoolevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_schoolevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    name = Column(String(120), nullable=False)
    ein = Column(Integer)
    is_alias_of_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbSourceevent(Base):
    __tablename__ = 'people_db_sourceevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_sourceevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    url = Column(String(2000), nullable=False)
    date_accessed = Column(Date)
    notes = Column(Text, nullable=False)
    person_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


t_public_search_opinion = Table(
    'public.search_opinion', metadata,
    Column('id', BigInteger),
    Column('date_created', Text),
    Column('date_modified', Text),
    Column('author_str', Float(53)),
    Column('per_curiam', Text),
    Column('joined_by_str', Float(53)),
    Column('type', Text),
    Column('sha1', Float(53)),
    Column('page_count', Float(53)),
    Column('download_url', Float(53)),
    Column('local_path', Float(53)),
    Column('plain_text', Float(53)),
    Column('html', Float(53)),
    Column('html_lawbox', Float(53)),
    Column('html_columbia', Float(53)),
    Column('html_anon_2020', Float(53)),
    Column('xml_harvard', Text),
    Column('html_with_citations', Float(53)),
    Column('extracted_by_ocr', Text),
    Column('author_id', Float(53)),
    Column('cluster_id', BigInteger)
)


class SearchBankruptcyinformationevent(Base):
    __tablename__ = 'search_bankruptcyinformationevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_bankruptcyinformationevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    date_converted = Column(DateTime(True))
    date_last_to_file_claims = Column(DateTime(True))
    date_last_to_file_govt = Column(DateTime(True))
    date_debtor_dismissed = Column(DateTime(True))
    chapter = Column(String(10), nullable=False)
    trustee_str = Column(Text, nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchCitationevent(Base):
    __tablename__ = 'search_citationevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_citationevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    volume = Column(SmallInteger, nullable=False)
    reporter = Column(Text, nullable=False)
    page = Column(Text, nullable=False)
    type = Column(SmallInteger, nullable=False)
    cluster_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchClaimevent(Base):
    __tablename__ = 'search_claimevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_claimevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    date_claim_modified = Column(DateTime(True))
    date_original_entered = Column(DateTime(True))
    date_original_filed = Column(DateTime(True))
    date_last_amendment_entered = Column(DateTime(True))
    date_last_amendment_filed = Column(DateTime(True))
    claim_number = Column(String(10), nullable=False)
    creditor_details = Column(Text, nullable=False)
    creditor_id = Column(String(50), nullable=False)
    status = Column(String(1000), nullable=False)
    entered_by = Column(String(1000), nullable=False)
    filed_by = Column(String(1000), nullable=False)
    amount_claimed = Column(String(100), nullable=False)
    unsecured_claimed = Column(String(100), nullable=False)
    secured_claimed = Column(String(100), nullable=False)
    priority_claimed = Column(String(100), nullable=False)
    description = Column(Text, nullable=False)
    remarks = Column(Text, nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchClaimhistoryevent(Base):
    __tablename__ = 'search_claimhistoryevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_claimhistoryevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    sha1 = Column(String(40), nullable=False)
    page_count = Column(Integer)
    file_size = Column(Integer)
    filepath_local = Column(String(1000), nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)
    thumbnail = Column(String(100))
    thumbnail_status = Column(SmallInteger, nullable=False)
    plain_text = Column(Text, nullable=False)
    ocr_status = Column(SmallInteger)
    date_upload = Column(DateTime(True))
    document_number = Column(String(32), nullable=False)
    attachment_number = Column(SmallInteger)
    pacer_doc_id = Column(String(32), nullable=False)
    is_available = Column(Boolean)
    is_free_on_pacer = Column(Boolean)
    is_sealed = Column(Boolean)
    date_filed = Column(Date)
    claim_document_type = Column(Integer, nullable=False)
    description = Column(Text, nullable=False)
    claim_doc_id = Column(String(32), nullable=False)
    pacer_dm_id = Column(Integer)
    pacer_case_id = Column(String(100), nullable=False)
    claim_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchClaimtagsevent(Base):
    __tablename__ = 'search_claimtagsevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_claimtagsevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    claim_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    tag_id = Column(Integer, nullable=False, index=True)


class SearchCourt(Base):
    __tablename__ = 'search_court'
    __table_args__ = (
        CheckConstraint('pacer_court_id >= 0'),
    )

    id = Column(String(15), primary_key=True, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    in_use = Column(Boolean, nullable=False)
    has_opinion_scraper = Column(Boolean, nullable=False)
    has_oral_argument_scraper = Column(Boolean, nullable=False)
    position = Column(Float(53), nullable=False, unique=True)
    citation_string = Column(String(100), nullable=False)
    short_name = Column(String(100), nullable=False)
    full_name = Column(String(200), nullable=False)
    url = Column(String(500), nullable=False)
    start_date = Column(Date)
    end_date = Column(Date)
    jurisdiction = Column(String(3), nullable=False)
    notes = Column(Text, nullable=False)
    pacer_court_id = Column(SmallInteger)
    fjc_court_id = Column(String(3), nullable=False)
    pacer_has_rss_feed = Column(Boolean)
    date_last_pacer_contact = Column(DateTime(True))
    pacer_rss_entry_types = Column(Text, nullable=False)


class SearchCourtevent(Base):
    __tablename__ = 'search_courtevent'
    __table_args__ = (
        CheckConstraint('pacer_court_id >= 0'),
    )

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_courtevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(String(15), nullable=False)
    pacer_court_id = Column(SmallInteger)
    pacer_has_rss_feed = Column(Boolean)
    pacer_rss_entry_types = Column(Text, nullable=False)
    date_last_pacer_contact = Column(DateTime(True))
    fjc_court_id = Column(String(3), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    in_use = Column(Boolean, nullable=False)
    has_opinion_scraper = Column(Boolean, nullable=False)
    has_oral_argument_scraper = Column(Boolean, nullable=False)
    position = Column(Float(53), nullable=False)
    citation_string = Column(String(100), nullable=False)
    short_name = Column(String(100), nullable=False)
    full_name = Column(String(200), nullable=False)
    url = Column(String(500), nullable=False)
    start_date = Column(Date)
    end_date = Column(Date)
    jurisdiction = Column(String(3), nullable=False)
    notes = Column(Text, nullable=False)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(String(15), nullable=False, index=True)


class SearchDocketentryevent(Base):
    __tablename__ = 'search_docketentryevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketentryevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    date_filed = Column(Date)
    entry_number = Column(BigInteger)
    recap_sequence_number = Column(String(50), nullable=False)
    pacer_sequence_number = Column(Integer)
    description = Column(Text, nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    time_filed = Column(Time)


class SearchDocketentrytagsevent(Base):
    __tablename__ = 'search_docketentrytagsevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketentrytagsevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    docketentry_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    tag_id = Column(Integer, nullable=False, index=True)


class SearchDocketevent(Base):
    __tablename__ = 'search_docketevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    source = Column(SmallInteger, nullable=False)
    appeal_from_str = Column(Text, nullable=False)
    assigned_to_str = Column(Text, nullable=False)
    referred_to_str = Column(Text, nullable=False)
    panel_str = Column(Text, nullable=False)
    date_last_index = Column(DateTime(True))
    date_cert_granted = Column(Date)
    date_cert_denied = Column(Date)
    date_argued = Column(Date)
    date_reargued = Column(Date)
    date_reargument_denied = Column(Date)
    date_filed = Column(Date)
    date_terminated = Column(Date)
    date_last_filing = Column(Date)
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    slug = Column(String(75), nullable=False)
    docket_number = Column(Text)
    docket_number_core = Column(String(20), nullable=False)
    pacer_case_id = Column(String(100))
    cause = Column(String(2000), nullable=False)
    nature_of_suit = Column(String(1000), nullable=False)
    jury_demand = Column(String(500), nullable=False)
    jurisdiction_type = Column(String(100), nullable=False)
    appellate_fee_status = Column(Text, nullable=False)
    appellate_case_type_information = Column(Text, nullable=False)
    mdl_status = Column(String(100), nullable=False)
    filepath_local = Column(String(1000), nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    filepath_ia_json = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)
    ia_needs_upload = Column(Boolean)
    ia_date_first_change = Column(DateTime(True))
    date_blocked = Column(Date)
    blocked = Column(Boolean, nullable=False)
    appeal_from_id = Column(String(15), index=True)
    assigned_to_id = Column(Integer, index=True)
    court_id = Column(String(15), nullable=False, index=True)
    idb_data_id = Column(Integer, index=True)
    originating_court_information_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    referred_to_id = Column(Integer, index=True)


class SearchDocketpanelevent(Base):
    __tablename__ = 'search_docketpanelevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketpanelevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)


class SearchDockettagsevent(Base):
    __tablename__ = 'search_dockettagsevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_dockettagsevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    tag_id = Column(Integer, nullable=False, index=True)


class SearchOpinionclusterevent(Base):
    __tablename__ = 'search_opinionclusterevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionclusterevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    judges = Column(Text, nullable=False)
    date_filed = Column(Date, nullable=False)
    date_filed_is_approximate = Column(Boolean, nullable=False)
    slug = Column(String(75))
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    scdb_id = Column(String(10), nullable=False)
    scdb_decision_direction = Column(Integer)
    scdb_votes_majority = Column(Integer)
    scdb_votes_minority = Column(Integer)
    source = Column(String(10), nullable=False)
    procedural_history = Column(Text, nullable=False)
    attorneys = Column(Text, nullable=False)
    nature_of_suit = Column(Text, nullable=False)
    posture = Column(Text, nullable=False)
    syllabus = Column(Text, nullable=False)
    headnotes = Column(Text, nullable=False)
    summary = Column(Text, nullable=False)
    disposition = Column(Text, nullable=False)
    history = Column(Text, nullable=False)
    other_dates = Column(Text, nullable=False)
    cross_reference = Column(Text, nullable=False)
    correction = Column(Text, nullable=False)
    citation_count = Column(Integer, nullable=False)
    precedential_status = Column(String(50), nullable=False)
    date_blocked = Column(Date)
    blocked = Column(Boolean, nullable=False)
    filepath_json_harvard = Column(String(1000), nullable=False)
    docket_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)
    arguments = Column(Text, nullable=False)
    headmatter = Column(Text, nullable=False)


class SearchOpinionclusternonparticipatingjudgesevent(Base):
    __tablename__ = 'search_opinionclusternonparticipatingjudgesevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionclusternonparticipatingjudgesevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    opinioncluster_id = Column(Integer, nullable=False, index=True)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)


class SearchOpinionclusterpanelevent(Base):
    __tablename__ = 'search_opinionclusterpanelevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionclusterpanelevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    opinioncluster_id = Column(Integer, nullable=False, index=True)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)


class SearchOpinionevent(Base):
    __tablename__ = 'search_opinionevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    author_str = Column(Text, nullable=False)
    per_curiam = Column(Boolean, nullable=False)
    joined_by_str = Column(Text, nullable=False)
    type = Column(String(20), nullable=False)
    sha1 = Column(String(40), nullable=False)
    page_count = Column(Integer)
    download_url = Column(String(500))
    local_path = Column(String(100), nullable=False)
    plain_text = Column(Text, nullable=False)
    html = Column(Text, nullable=False)
    html_lawbox = Column(Text, nullable=False)
    html_columbia = Column(Text, nullable=False)
    html_anon_2020 = Column(Text, nullable=False)
    xml_harvard = Column(Text, nullable=False)
    html_with_citations = Column(Text, nullable=False)
    extracted_by_ocr = Column(Boolean, nullable=False)
    author_id = Column(Integer, index=True)
    cluster_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchOpinionjoinedbyevent(Base):
    __tablename__ = 'search_opinionjoinedbyevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionjoinedbyevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    opinion_id = Column(Integer, nullable=False, index=True)
    person_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)


class SearchOriginatingcourtinformationevent(Base):
    __tablename__ = 'search_originatingcourtinformationevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_originatingcourtinformationevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    docket_number = Column(Text, nullable=False)
    assigned_to_str = Column(Text, nullable=False)
    ordering_judge_str = Column(Text, nullable=False)
    court_reporter = Column(Text, nullable=False)
    date_disposed = Column(Date)
    date_filed = Column(Date)
    date_judgment = Column(Date)
    date_judgment_eod = Column(Date)
    date_filed_noa = Column(Date)
    date_received_coa = Column(Date)
    assigned_to_id = Column(Integer, index=True)
    ordering_judge_id = Column(Integer, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchParenthetical(Base):
    __tablename__ = 'search_parenthetical'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_parenthetical_id_seq'::regclass)"))
    text = Column(Text, nullable=False)
    score = Column(Float(53), nullable=False, index=True)
    described_opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    describing_opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    group_id = Column(ForeignKey('search_parentheticalgroup.id', deferrable=True, initially='DEFERRED'), index=True)

    described_opinion = relationship('SearchOpinion', primaryjoin='SearchParenthetical.described_opinion_id == SearchOpinion.id')
    describing_opinion = relationship('SearchOpinion', primaryjoin='SearchParenthetical.describing_opinion_id == SearchOpinion.id')
    group = relationship('SearchParentheticalgroup', primaryjoin='SearchParenthetical.group_id == SearchParentheticalgroup.id')


class SearchParentheticalgroup(Base):
    __tablename__ = 'search_parentheticalgroup'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_parentheticalgroup_id_seq'::regclass)"))
    score = Column(Float(53), nullable=False, index=True)
    size = Column(Integer, nullable=False)
    opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    representative_id = Column(ForeignKey('search_parenthetical.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    opinion = relationship('SearchOpinion')
    representative = relationship('SearchParenthetical', primaryjoin='SearchParentheticalgroup.representative_id == SearchParenthetical.id')


class SearchRecapdocumentevent(Base):
    __tablename__ = 'search_recapdocumentevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_recapdocumentevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    sha1 = Column(String(40), nullable=False)
    page_count = Column(Integer)
    file_size = Column(Integer)
    filepath_local = Column(String(1000), nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)
    thumbnail = Column(String(100))
    thumbnail_status = Column(SmallInteger, nullable=False)
    plain_text = Column(Text, nullable=False)
    ocr_status = Column(SmallInteger)
    date_upload = Column(DateTime(True))
    document_number = Column(String(32), nullable=False)
    attachment_number = Column(SmallInteger)
    pacer_doc_id = Column(String(32), nullable=False)
    is_available = Column(Boolean)
    is_free_on_pacer = Column(Boolean)
    is_sealed = Column(Boolean)
    document_type = Column(Integer, nullable=False)
    description = Column(Text, nullable=False)
    docket_entry_id = Column(Integer, nullable=False, index=True)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class SearchRecapdocumenttagsevent(Base):
    __tablename__ = 'search_recapdocumenttagsevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_recapdocumenttagsevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    pgh_context_id = Column(UUID, index=True)
    recapdocument_id = Column(Integer, nullable=False, index=True)
    tag_id = Column(Integer, nullable=False, index=True)


class SearchTag(Base):
    __tablename__ = 'search_tag'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_tag_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    name = Column(String(50), nullable=False, unique=True)


class SearchTagevent(Base):
    __tablename__ = 'search_tagevent'

    pgh_id = Column(Integer, primary_key=True, server_default=text("nextval('search_tagevent_pgh_id_seq'::regclass)"))
    pgh_created_at = Column(DateTime(True), nullable=False)
    pgh_label = Column(Text, nullable=False)
    id = Column(Integer, nullable=False)
    date_created = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    name = Column(String(50), nullable=False)
    pgh_context_id = Column(UUID, index=True)
    pgh_obj_id = Column(Integer, nullable=False, index=True)


class PeopleDbAbarating(Base):
    __tablename__ = 'people_db_abarating'
    __table_args__ = (
        CheckConstraint('year_rated >= 0'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_abarating_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    rating = Column(String(5), nullable=False)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    year_rated = Column(SmallInteger)

    person = relationship('PeopleDbPerson')


class PeopleDbEducation(Base):
    __tablename__ = 'people_db_education'
    __table_args__ = (
        CheckConstraint('degree_year >= 0'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_education_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    degree_detail = Column(String(100), nullable=False)
    degree_year = Column(SmallInteger)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    school_id = Column(ForeignKey('people_db_school.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    degree_level = Column(String(4), nullable=False)

    person = relationship('PeopleDbPerson')
    school = relationship('PeopleDbSchool')


class PeopleDbPersonRace(Base):
    __tablename__ = 'people_db_person_race'
    __table_args__ = (
        UniqueConstraint('person_id', 'race_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_person_race_id_seq'::regclass)"))
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    race_id = Column(ForeignKey('people_db_race.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    person = relationship('PeopleDbPerson')
    race = relationship('PeopleDbRace')


class PeopleDbPoliticalaffiliation(Base):
    __tablename__ = 'people_db_politicalaffiliation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_politicalaffiliation_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    political_party = Column(String(5), nullable=False)
    source = Column(String(5), nullable=False)
    date_start = Column(Date)
    date_granularity_start = Column(String(15), nullable=False)
    date_end = Column(Date)
    date_granularity_end = Column(String(15), nullable=False)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)

    person = relationship('PeopleDbPerson')


class PeopleDbPosition(Base):
    __tablename__ = 'people_db_position'
    __table_args__ = (
        CheckConstraint('votes_no >= 0'),
        CheckConstraint('votes_yes >= 0')
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_position_id_seq'::regclass)"))
    position_type = Column(String(20))
    job_title = Column(String(100), nullable=False)
    organization_name = Column(String(120))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_nominated = Column(Date, index=True)
    date_elected = Column(Date, index=True)
    date_recess_appointment = Column(Date, index=True)
    date_referred_to_judicial_committee = Column(Date, index=True)
    date_judicial_committee_action = Column(Date, index=True)
    date_hearing = Column(Date, index=True)
    date_confirmation = Column(Date, index=True)
    date_start = Column(Date, index=True)
    date_granularity_start = Column(String(15), nullable=False)
    date_retirement = Column(Date, index=True)
    date_termination = Column(Date, index=True)
    date_granularity_termination = Column(String(15), nullable=False)
    judicial_committee_action = Column(String(20), nullable=False)
    nomination_process = Column(String(20), nullable=False)
    voice_vote = Column(Boolean)
    votes_yes = Column(Integer)
    votes_no = Column(Integer)
    how_selected = Column(String(20), nullable=False)
    termination_reason = Column(String(25), nullable=False)
    court_id = Column(ForeignKey('search_court.id', deferrable=True, initially='DEFERRED'), index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    school_id = Column(ForeignKey('people_db_school.id', deferrable=True, initially='DEFERRED'), index=True)
    appointer_id = Column(ForeignKey('people_db_position.id', deferrable=True, initially='DEFERRED'), index=True)
    predecessor_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    supervisor_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    vote_type = Column(String(2), nullable=False)
    votes_no_percent = Column(Float(53))
    votes_yes_percent = Column(Float(53))
    location_city = Column(String(50), nullable=False)
    location_state = Column(String(2), nullable=False)
    has_inferred_values = Column(Boolean, nullable=False)
    sector = Column(SmallInteger)

    appointer = relationship('PeopleDbPosition', remote_side=[id])
    court = relationship('SearchCourt')
    person = relationship('PeopleDbPerson', primaryjoin='PeopleDbPosition.person_id == PeopleDbPerson.id')
    predecessor = relationship('PeopleDbPerson', primaryjoin='PeopleDbPosition.predecessor_id == PeopleDbPerson.id')
    school = relationship('PeopleDbSchool')
    supervisor = relationship('PeopleDbPerson', primaryjoin='PeopleDbPosition.supervisor_id == PeopleDbPerson.id')


class PeopleDbSource(Base):
    __tablename__ = 'people_db_source'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_source_id_seq'::regclass)"))
    date_modified = Column(DateTime(True), nullable=False, index=True)
    url = Column(String(2000), nullable=False)
    date_accessed = Column(Date)
    notes = Column(Text, nullable=False)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    date_created = Column(DateTime(True), nullable=False, index=True)

    person = relationship('PeopleDbPerson')


class SearchOriginatingcourtinformation(Base):
    __tablename__ = 'search_originatingcourtinformation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_originatingcourtinformation_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    assigned_to_str = Column(Text, nullable=False)
    court_reporter = Column(Text, nullable=False)
    date_disposed = Column(Date)
    date_filed = Column(Date)
    date_judgment = Column(Date)
    date_judgment_eod = Column(Date)
    date_filed_noa = Column(Date)
    date_received_coa = Column(Date)
    assigned_to_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    docket_number = Column(Text, nullable=False)
    ordering_judge_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    ordering_judge_str = Column(Text, nullable=False)

    assigned_to = relationship('PeopleDbPerson', primaryjoin='SearchOriginatingcourtinformation.assigned_to_id == PeopleDbPerson.id')
    ordering_judge = relationship('PeopleDbPerson', primaryjoin='SearchOriginatingcourtinformation.ordering_judge_id == PeopleDbPerson.id')


class PeopleDbRetentionevent(Base):
    __tablename__ = 'people_db_retentionevent'
    __table_args__ = (
        CheckConstraint('votes_no >= 0'),
        CheckConstraint('votes_yes >= 0')
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_retentionevent_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    retention_type = Column(String(10), nullable=False)
    date_retention = Column(Date, nullable=False, index=True)
    votes_yes = Column(Integer)
    votes_no = Column(Integer)
    unopposed = Column(Boolean)
    won = Column(Boolean)
    position_id = Column(ForeignKey('people_db_position.id', deferrable=True, initially='DEFERRED'), index=True)
    votes_no_percent = Column(Float(53))
    votes_yes_percent = Column(Float(53))

    position = relationship('PeopleDbPosition')


class SearchDocket(Base):
    __tablename__ = 'search_docket'
    __table_args__ = (
        UniqueConstraint('docket_number', 'pacer_case_id', 'court_id'),
        Index('search_dock_court_i_a043ae_idx', 'court_id', 'id'),
        Index('district_court_docket_lookup_idx', 'court_id', 'docket_number_core', 'pacer_case_id')
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_docket_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_argued = Column(Date)
    date_reargued = Column(Date)
    date_reargument_denied = Column(Date)
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    slug = Column(String(75), nullable=False)
    docket_number = Column(Text, index=True)
    date_blocked = Column(Date, index=True)
    blocked = Column(Boolean, nullable=False)
    court_id = Column(ForeignKey('search_court.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    date_cert_denied = Column(Date)
    date_cert_granted = Column(Date)
    assigned_to_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    cause = Column(String(2000), nullable=False)
    date_filed = Column(Date)
    date_last_filing = Column(Date)
    date_terminated = Column(Date)
    filepath_ia = Column(String(1000), nullable=False)
    filepath_local = Column(String(1000), nullable=False)
    jurisdiction_type = Column(String(100), nullable=False)
    jury_demand = Column(String(500), nullable=False)
    nature_of_suit = Column(String(1000), nullable=False)
    pacer_case_id = Column(String(100), index=True)
    referred_to_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    source = Column(SmallInteger, nullable=False)
    assigned_to_str = Column(Text, nullable=False)
    referred_to_str = Column(Text, nullable=False)
    view_count = Column(Integer, nullable=False)
    date_last_index = Column(DateTime(True))
    appeal_from_id = Column(ForeignKey('search_court.id', deferrable=True, initially='DEFERRED'), index=True)
    appeal_from_str = Column(Text, nullable=False)
    appellate_case_type_information = Column(Text, nullable=False)
    appellate_fee_status = Column(Text, nullable=False)
    panel_str = Column(Text, nullable=False)
    originating_court_information_id = Column(ForeignKey('search_originatingcourtinformation.id', deferrable=True, initially='DEFERRED'), unique=True)
    mdl_status = Column(String(100), nullable=False)
    filepath_ia_json = Column(String(1000), nullable=False)
    ia_date_first_change = Column(DateTime(True))
    ia_needs_upload = Column(Boolean)
    ia_upload_failure_count = Column(SmallInteger)
    docket_number_core = Column(String(20), nullable=False, index=True)
    idb_data_id = Column(Integer, unique=True)

    appeal_from = relationship('SearchCourt', primaryjoin='SearchDocket.appeal_from_id == SearchCourt.id')
    assigned_to = relationship('PeopleDbPerson', primaryjoin='SearchDocket.assigned_to_id == PeopleDbPerson.id')
    court = relationship('SearchCourt', primaryjoin='SearchDocket.court_id == SearchCourt.id')
    originating_court_information = relationship('SearchOriginatingcourtinformation', uselist=False)
    referred_to = relationship('PeopleDbPerson', primaryjoin='SearchDocket.referred_to_id == PeopleDbPerson.id')


class AudioAudio(Base):
    __tablename__ = 'audio_audio'

    id = Column(Integer, primary_key=True, server_default=text("nextval('audio_audio_id_seq'::regclass)"))
    source = Column(String(10), nullable=False)
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    judges = Column(Text)
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    sha1 = Column(String(40), nullable=False, index=True)
    download_url = Column(String(500), index=True)
    local_path_mp3 = Column(String(100), nullable=False, index=True)
    local_path_original_file = Column(String(100), nullable=False, index=True)
    duration = Column(SmallInteger)
    processing_complete = Column(Boolean, nullable=False)
    date_blocked = Column(Date, index=True)
    blocked = Column(Boolean, nullable=False, index=True)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), index=True)
    stt_google_response = Column(Text, nullable=False)
    stt_status = Column(SmallInteger, nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)

    docket = relationship('SearchDocket')


class PeopleDbAttorneyorganizationassociation(Base):
    __tablename__ = 'people_db_attorneyorganizationassociation'
    __table_args__ = (
        UniqueConstraint('attorney_id', 'attorney_organization_id', 'docket_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_attorneyorganizationassociation_id_seq'::regclass)"))
    attorney_id = Column(ForeignKey('people_db_attorney.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    attorney_organization_id = Column(ForeignKey('people_db_attorneyorganization.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    attorney = relationship('PeopleDbAttorney')
    attorney_organization = relationship('PeopleDbAttorneyorganization')
    docket = relationship('SearchDocket')


class PeopleDbPartytype(Base):
    __tablename__ = 'people_db_partytype'
    __table_args__ = (
        UniqueConstraint('docket_id', 'party_id', 'name'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_partytype_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, index=True)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    party_id = Column(ForeignKey('people_db_party.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    date_terminated = Column(Date)
    extra_info = Column(Text, nullable=False, index=True)
    highest_offense_level_opening = Column(Text, nullable=False)
    highest_offense_level_terminated = Column(Text, nullable=False)

    docket = relationship('SearchDocket')
    party = relationship('PeopleDbParty')


class PeopleDbRole(Base):
    __tablename__ = 'people_db_role'
    __table_args__ = (
        UniqueConstraint('party_id', 'attorney_id', 'role', 'docket_id', 'date_action'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_role_id_seq'::regclass)"))
    role = Column(SmallInteger, index=True)
    date_action = Column(Date)
    attorney_id = Column(ForeignKey('people_db_attorney.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    party_id = Column(ForeignKey('people_db_party.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    role_raw = Column(Text, nullable=False)

    attorney = relationship('PeopleDbAttorney')
    docket = relationship('SearchDocket')
    party = relationship('PeopleDbParty')


class SearchBankruptcyinformation(Base):
    __tablename__ = 'search_bankruptcyinformation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_bankruptcyinformation_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_converted = Column(DateTime(True))
    date_last_to_file_claims = Column(DateTime(True))
    date_last_to_file_govt = Column(DateTime(True))
    date_debtor_dismissed = Column(DateTime(True))
    chapter = Column(String(10), nullable=False)
    trustee_str = Column(Text, nullable=False)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, unique=True)

    docket = relationship('SearchDocket', uselist=False)


class SearchClaim(Base):
    __tablename__ = 'search_claim'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_claim_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_claim_modified = Column(DateTime(True))
    date_original_entered = Column(DateTime(True))
    date_original_filed = Column(DateTime(True))
    date_last_amendment_entered = Column(DateTime(True))
    date_last_amendment_filed = Column(DateTime(True))
    claim_number = Column(String(10), nullable=False, index=True)
    creditor_details = Column(Text, nullable=False)
    creditor_id = Column(String(50), nullable=False)
    status = Column(String(1000), nullable=False)
    entered_by = Column(String(1000), nullable=False)
    filed_by = Column(String(1000), nullable=False)
    amount_claimed = Column(String(100), nullable=False)
    unsecured_claimed = Column(String(100), nullable=False)
    secured_claimed = Column(String(100), nullable=False)
    priority_claimed = Column(String(100), nullable=False)
    description = Column(Text, nullable=False)
    remarks = Column(Text, nullable=False)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    docket = relationship('SearchDocket')


class SearchDocketPanel(Base):
    __tablename__ = 'search_docket_panel'
    __table_args__ = (
        UniqueConstraint('docket_id', 'person_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_docket_panel_id_seq'::regclass)"))
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    docket = relationship('SearchDocket')
    person = relationship('PeopleDbPerson')


class SearchDocketTag(Base):
    __tablename__ = 'search_docket_tags'
    __table_args__ = (
        UniqueConstraint('docket_id', 'tag_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_docket_tags_id_seq'::regclass)"))
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    tag_id = Column(ForeignKey('search_tag.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    docket = relationship('SearchDocket')
    tag = relationship('SearchTag')


class SearchDocketentry(Base):
    __tablename__ = 'search_docketentry'
    __table_args__ = (
        Index('search_dock_recap_s_306ab9_idx', 'recap_sequence_number', 'entry_number'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketentry_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_filed = Column(Date)
    entry_number = Column(BigInteger)
    description = Column(Text, nullable=False)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    pacer_sequence_number = Column(Integer)
    recap_sequence_number = Column(String(50), nullable=False)
    time_filed = Column(Time)

    docket = relationship('SearchDocket')


class SearchOpinioncluster(Base):
    __tablename__ = 'search_opinioncluster'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinioncluster_id_seq'::regclass)"))
    judges = Column(Text, nullable=False)
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_filed = Column(Date, nullable=False, index=True)
    slug = Column(String(75))
    case_name_short = Column(Text, nullable=False)
    case_name = Column(Text, nullable=False)
    case_name_full = Column(Text, nullable=False)
    scdb_id = Column(String(10), nullable=False, index=True)
    source = Column(String(10), nullable=False)
    procedural_history = Column(Text, nullable=False)
    attorneys = Column(Text, nullable=False)
    nature_of_suit = Column(Text, nullable=False)
    posture = Column(Text, nullable=False)
    syllabus = Column(Text, nullable=False)
    citation_count = Column(Integer, nullable=False, index=True)
    precedential_status = Column(String(50), nullable=False, index=True)
    date_blocked = Column(Date, index=True)
    blocked = Column(Boolean, nullable=False, index=True)
    docket_id = Column(ForeignKey('search_docket.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    scdb_decision_direction = Column(Integer)
    scdb_votes_majority = Column(Integer)
    scdb_votes_minority = Column(Integer)
    date_filed_is_approximate = Column(Boolean, nullable=False)
    correction = Column(Text, nullable=False)
    cross_reference = Column(Text, nullable=False)
    disposition = Column(Text, nullable=False)
    filepath_json_harvard = Column(String(1000), nullable=False, index=True)
    headnotes = Column(Text, nullable=False)
    history = Column(Text, nullable=False)
    other_dates = Column(Text, nullable=False)
    summary = Column(Text, nullable=False)
    arguments = Column(Text, nullable=False)
    headmatter = Column(Text, nullable=False)

    docket = relationship('SearchDocket')


class AudioAudioPanel(Base):
    __tablename__ = 'audio_audio_panel'
    __table_args__ = (
        UniqueConstraint('audio_id', 'person_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('audio_audio_panel_id_seq'::regclass)"))
    audio_id = Column(ForeignKey('audio_audio.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    audio = relationship('AudioAudio')
    person = relationship('PeopleDbPerson')


class PeopleDbCriminalcomplaint(Base):
    __tablename__ = 'people_db_criminalcomplaint'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_criminalcomplaint_id_seq'::regclass)"))
    name = Column(Text, nullable=False)
    disposition = Column(Text, nullable=False)
    party_type_id = Column(ForeignKey('people_db_partytype.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    party_type = relationship('PeopleDbPartytype')


class PeopleDbCriminalcount(Base):
    __tablename__ = 'people_db_criminalcount'

    id = Column(Integer, primary_key=True, server_default=text("nextval('people_db_criminalcount_id_seq'::regclass)"))
    name = Column(Text, nullable=False)
    disposition = Column(Text, nullable=False)
    status = Column(SmallInteger, nullable=False)
    party_type_id = Column(ForeignKey('people_db_partytype.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    party_type = relationship('PeopleDbPartytype')


class SearchCitation(Base):
    __tablename__ = 'search_citation'
    __table_args__ = (
        UniqueConstraint('cluster_id', 'volume', 'reporter', 'page'),
        Index('search_cita_volume_92c344_idx', 'volume', 'reporter', 'page'),
        Index('search_cita_volume_464334_idx', 'volume', 'reporter')
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_citation_id_seq'::regclass)"))
    volume = Column(SmallInteger, nullable=False)
    reporter = Column(Text, nullable=False, index=True)
    page = Column(Text, nullable=False)
    type = Column(SmallInteger, nullable=False)
    cluster_id = Column(ForeignKey('search_opinioncluster.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    cluster = relationship('SearchOpinioncluster')


class SearchClaimTag(Base):
    __tablename__ = 'search_claim_tags'
    __table_args__ = (
        UniqueConstraint('claim_id', 'tag_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_claim_tags_id_seq'::regclass)"))
    claim_id = Column(ForeignKey('search_claim.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    tag_id = Column(ForeignKey('search_tag.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    claim = relationship('SearchClaim')
    tag = relationship('SearchTag')


class SearchClaimhistory(Base):
    __tablename__ = 'search_claimhistory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_claimhistory_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_upload = Column(DateTime(True))
    document_number = Column(String(32), nullable=False, index=True)
    attachment_number = Column(SmallInteger)
    pacer_doc_id = Column(String(32), nullable=False)
    is_available = Column(Boolean)
    sha1 = Column(String(40), nullable=False)
    page_count = Column(Integer)
    file_size = Column(Integer)
    filepath_local = Column(String(1000), nullable=False)
    filepath_ia = Column(String(1000), nullable=False)
    ia_upload_failure_count = Column(SmallInteger)
    thumbnail = Column(String(100))
    thumbnail_status = Column(SmallInteger, nullable=False)
    plain_text = Column(Text, nullable=False)
    ocr_status = Column(SmallInteger)
    is_free_on_pacer = Column(Boolean, index=True)
    is_sealed = Column(Boolean)
    date_filed = Column(Date)
    claim_document_type = Column(Integer, nullable=False)
    description = Column(Text, nullable=False)
    claim_doc_id = Column(String(32), nullable=False)
    pacer_dm_id = Column(Integer)
    pacer_case_id = Column(String(100), nullable=False)
    claim_id = Column(ForeignKey('search_claim.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    claim = relationship('SearchClaim')


class SearchDocketentryTag(Base):
    __tablename__ = 'search_docketentry_tags'
    __table_args__ = (
        UniqueConstraint('docketentry_id', 'tag_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_docketentry_tags_id_seq'::regclass)"))
    docketentry_id = Column(ForeignKey('search_docketentry.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    tag_id = Column(ForeignKey('search_tag.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    docketentry = relationship('SearchDocketentry')
    tag = relationship('SearchTag')


class SearchOpinion(Base):
    __tablename__ = 'search_opinion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinion_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    type = Column(String(20), nullable=False)
    sha1 = Column(String(40), nullable=False, index=True)
    download_url = Column(String(500), index=True)
    local_path = Column(String(100), nullable=False, index=True)
    plain_text = Column(Text, nullable=False)
    html = Column(Text, nullable=False)
    html_lawbox = Column(Text, nullable=False)
    html_columbia = Column(Text, nullable=False)
    html_with_citations = Column(Text, nullable=False)
    extracted_by_ocr = Column(Boolean, nullable=False, index=True)
    author_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), index=True)
    cluster_id = Column(ForeignKey('search_opinioncluster.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    per_curiam = Column(Boolean, nullable=False)
    page_count = Column(Integer)
    author_str = Column(Text, nullable=False)
    joined_by_str = Column(Text, nullable=False)
    xml_harvard = Column(Text, nullable=False)
    html_anon_2020 = Column(Text, nullable=False)

    author = relationship('PeopleDbPerson')
    cluster = relationship('SearchOpinioncluster')


class SearchOpinionclusterNonParticipatingJudge(Base):
    __tablename__ = 'search_opinioncluster_non_participating_judges'
    __table_args__ = (
        UniqueConstraint('opinioncluster_id', 'person_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinioncluster_non_participating_judges_id_seq'::regclass)"))
    opinioncluster_id = Column(ForeignKey('search_opinioncluster.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    opinioncluster = relationship('SearchOpinioncluster')
    person = relationship('PeopleDbPerson')


class SearchOpinionclusterPanel(Base):
    __tablename__ = 'search_opinioncluster_panel'
    __table_args__ = (
        UniqueConstraint('opinioncluster_id', 'person_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinioncluster_panel_id_seq'::regclass)"))
    opinioncluster_id = Column(ForeignKey('search_opinioncluster.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    opinioncluster = relationship('SearchOpinioncluster')
    person = relationship('PeopleDbPerson')


class SearchRecapdocument(Base):
    __tablename__ = 'search_recapdocument'
    __table_args__ = (
        UniqueConstraint('docket_entry_id', 'document_number', 'attachment_number'),
        Index('search_reca_documen_cc5acd_idx', 'document_type', 'document_number', 'attachment_number')
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_recapdocument_id_seq'::regclass)"))
    date_created = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    date_upload = Column(DateTime(True))
    document_type = Column(Integer, nullable=False)
    document_number = Column(String(32), nullable=False, index=True)
    attachment_number = Column(SmallInteger)
    pacer_doc_id = Column(String(32), nullable=False, index=True)
    is_available = Column(Boolean)
    sha1 = Column(String(40), nullable=False)
    filepath_local = Column(String(1000), nullable=False, index=True)
    filepath_ia = Column(String(1000), nullable=False)
    docket_entry_id = Column(ForeignKey('search_docketentry.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    description = Column(Text, nullable=False)
    ocr_status = Column(SmallInteger)
    plain_text = Column(Text, nullable=False)
    page_count = Column(Integer)
    is_free_on_pacer = Column(Boolean, index=True)
    ia_upload_failure_count = Column(SmallInteger)
    file_size = Column(Integer)
    thumbnail = Column(String(100))
    thumbnail_status = Column(SmallInteger, nullable=False)
    is_sealed = Column(Boolean)

    docket_entry = relationship('SearchDocketentry')


class SearchOpinionJoinedBy(Base):
    __tablename__ = 'search_opinion_joined_by'
    __table_args__ = (
        UniqueConstraint('opinion_id', 'person_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinion_joined_by_id_seq'::regclass)"))
    opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    person_id = Column(ForeignKey('people_db_person.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    opinion = relationship('SearchOpinion')
    person = relationship('PeopleDbPerson')


class SearchOpinionscited(Base):
    __tablename__ = 'search_opinionscited'
    __table_args__ = (
        UniqueConstraint('citing_opinion_id', 'cited_opinion_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionscited_id_seq'::regclass)"))
    cited_opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    citing_opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    depth = Column(Integer, nullable=False, index=True)

    cited_opinion = relationship('SearchOpinion', primaryjoin='SearchOpinionscited.cited_opinion_id == SearchOpinion.id')
    citing_opinion = relationship('SearchOpinion', primaryjoin='SearchOpinionscited.citing_opinion_id == SearchOpinion.id')


class SearchOpinionscitedbyrecapdocument(Base):
    __tablename__ = 'search_opinionscitedbyrecapdocument'
    __table_args__ = (
        UniqueConstraint('citing_document_id', 'cited_opinion_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_opinionscitedbyrecapdocument_id_seq'::regclass)"))
    depth = Column(Integer, nullable=False, index=True)
    cited_opinion_id = Column(ForeignKey('search_opinion.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    citing_document_id = Column(ForeignKey('search_recapdocument.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    cited_opinion = relationship('SearchOpinion')
    citing_document = relationship('SearchRecapdocument')


class SearchRecapdocumentTag(Base):
    __tablename__ = 'search_recapdocument_tags'
    __table_args__ = (
        UniqueConstraint('recapdocument_id', 'tag_id'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('search_recapdocument_tags_id_seq'::regclass)"))
    recapdocument_id = Column(ForeignKey('search_recapdocument.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)
    tag_id = Column(ForeignKey('search_tag.id', deferrable=True, initially='DEFERRED'), nullable=False, index=True)

    recapdocument = relationship('SearchRecapdocument')
    tag = relationship('SearchTag')
