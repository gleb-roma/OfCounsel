import sqlalchemy
from research_copilot.db.courtlistener_models import SearchOpinion

engine = sqlalchemy.create_engine("postgresql+psycopg2://taylor:postgres@localhost:5432/courtlistener") 

def get_search_opinion_by_id(opinion_id: int):
    with engine.connect() as conn:
        # query search_opinion table by id:
        query = sqlalchemy.select(SearchOpinion).where(SearchOpinion.id == opinion_id)
        result = conn.execute(query).fetchall() 
        if len(result) == 0:
            return None
        elif len(result) == 1:
            return result[0]
        else:
            raise Exception("More than one result found for id: {}".format(opinion_id))

class RECAP_CODES:
    INSURANCE = 110
    OVERPAYMENTS_AND_ENFORCEMENTS = 150
    RECOVERY_OF_VET_BENEFITS_OVERPAYMENTS = 153
    STOCKHOLDER_SUITS = 160
    CONTRACT_OTHER = 190
    CONTRACT_PRODUCT_LIABILITY = 195
    CONTRACT_FRANCHISE = 196
    FRAUD_OTHER = 370
    TRUTH_IN_LENDING = 371
    FALSE_CLAIMS_ACT = 375
    STATE_RE_APPORTIONMENT = 400
    ANTITRUST = 410
    BANKRUPTCY_APPEALS = 422
    BANKRUPTCY_WITHDRAWAL = 423
    BANKS_AND_BANKING = 430
    CIVIL_RICO = 470
    INTERSTATE_COMMERCE = 450
    PATENT_ANDA = 835
    SECURITIES_COMMODITIES_EXCHANGE = 850