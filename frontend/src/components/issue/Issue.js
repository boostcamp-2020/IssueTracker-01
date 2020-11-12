import React from 'react';
import styled from 'styled-components';
import SVG from '@components/utils/SVG';
import { formatDistance, subHours } from 'date-fns';

const Issue = ({ item }) => {
  return (
    <FlexDiv>
      <StyledCheckboxLabel>
        <input type="checkbox" name="issues[]" />
      </StyledCheckboxLabel>
      <SVGDiv>
        <span>
          {item.isOpen === 1 ? (
            <SVG name="issueStatusOpen" size="16px" color="#22863a" />
          ) : (
            <SVG name="issueStatusClose" size="16px" color="#cb2431" />
          )}
        </span>
      </SVGDiv>
      <IssueTitleColumn>
        <IssueTitle href={`/deatilissue/${item.issueId}`}>{item.title}</IssueTitle>
        <span>
          {item.IssueLabels.map((issueLabel) => {
            return (
              <PreviewLabel key={issueLabel.id} color={issueLabel.Label.color}>
                <span>{issueLabel.Label.labelName}</span>
              </PreviewLabel>
            );
          })}
        </span>
        <IssueInfo>
          {item.isOpen === 1
            ? `#${item.issueId} opend on ${formatDistance(subHours(new Date(item.createdAt), 9), new Date())} ago by ${
                item.UserAuthor.userId
              }`
            : `#${item.issueId} by ${item.UserAuthor.userId} was closed`}
        </IssueInfo>
      </IssueTitleColumn>
      <IssueEtc>
        <Etc>{item.User && item.User.profile_url ? <Profile src={item.User.profile_url} /> : ''}</Etc>
      </IssueEtc>
    </FlexDiv>
  );
};

const FlexDiv = styled.div`
  display: flex;
  border: 1px solid #eaecef;
  border-top: 0;
`;

const StyledCheckboxLabel = styled.label`
  display: block;
  padding-left: 16px;
  padding-top: 8px;
  padding-bottom: 8px;
`;

const SVGDiv = styled.div`
  padding-left: 16px;
  padding-top: 8px;
  padding-bottom: 8px;
`;

const IssueTitleColumn = styled.div`
  padding: 8px;
  flex: auto;
  line-height: 1.5;
`;

const IssueTitle = styled.a`
  font-weight: 600;
  font-size: 16px;
  vertical-align: middle;
  color: #24292e;
  text-decoration: none;
`;

const IssueInfo = styled.div`
  font-size: 12px;
  color: #586069;
`;

const PreviewLabel = styled.span`
  display: inline-block;
  background: ${(props) => props.color};
  color: #fff;
  font-size: 12px;
  font-weight: 500;
  padding: 0 10px;
  line-height: 22px;
  border: 1px solid transparent;
  border-radius: 2em;
  margin: 0 2px;
`;

const IssueEtc = styled.div`
  padding: 8px 16px 8px 0;
`;

const Etc = styled.div``;

const Profile = styled.img`
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border-style: none;
  overflow: hidden;
  box-shadow: 0 0 0 1px transparent;
`;

export default Issue;
