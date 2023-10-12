"use client"

import type { NextPage } from 'next'
import axios from 'axios';
import { useState, useEffect } from 'react';
import Head from 'next/head'
import Image from 'next/image'

import { ReloadIcon } from "@radix-ui/react-icons"
import { Button } from "@/components/ui/button"
import { Label } from "@/components/ui/label"
import { Separator } from "@/components/ui/separator"
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs"
import { Textarea } from "@/components/ui/textarea"

import { ExclamationTriangleIcon } from "@radix-ui/react-icons"
 
import {
  Alert,
  AlertDescription,
  AlertTitle,
} from "@/components/ui/alert"

import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"


import {docTitle, originalDocText, newDocText, summaryOfChanges, docDiff} from "./data/document"

export function ChatArea() {

  const [agentAnswer, setAgentAnswer] = useState('')
  const [userQuestion, setUserQuestion] = useState('');
  const [ask, setAsk] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isError, setIsError] = useState(false);

  useEffect(() => {
    if (ask != '') {
    const fetchData = async () => {
      setIsError(false);
      setIsLoading(true);
      setAgentAnswer('');

      try {
        const result = await fetch('/api/ask',{
          method: 'POST',
          body: JSON.stringify({ask})
        });
        const data = await result.json();
        setAgentAnswer(data.message);
      } catch (error) {
        setIsError(true);
        setAgentAnswer('');
      }
      setIsLoading(false);
    };
    fetchData();
    }
  }, [ask]);

  return (
    <div className="grid w-full gap-2 text-left">
      <Label htmlFor="userQuestion">Ask OfCounsel</Label>
      <Textarea 
        value={userQuestion}
        placeholder="Type your question here" 
        onChange={event => setUserQuestion(event.target.value)}
      />      
      {isLoading ? (
        <Button disabled>
          <ReloadIcon className="mr-2 h-4 w-4 animate-spin" />
          Please wait
        </Button>
      ) : (
        <Button onClick={() => setAsk(userQuestion)}>
          Submit
        </Button>
      )}
      {isError &&
          <Alert variant="destructive">
          <ExclamationTriangleIcon className="h-4 w-4" />
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>
            Something went wrong. Please try again.
          </AlertDescription>
        </Alert>
      }
      {agentAnswer &&
          <div className="h-full w-full">
            <br />
            <div className="flex items-center space-x-4">
              <Avatar>
                {/* <AvatarImage src="https://github.com/shadcn.png" /> */}
                <AvatarImage src="/agent.png" />
                <AvatarFallback>CN</AvatarFallback>
              </Avatar>
              <div>
                <p className="text-sm font-medium leading-none">OfCounsel</p>
              </div>
            </div>
            <br />
            <Textarea 
              value={agentAnswer}
              className="min-h-[400px] flex-1 p-4 md:min-h-[700px] lg:min-h-[500px]"
            />
        </div>
      }
    </div>
  )
}

function DocumentViewer() {
  return (
    <>
      <div className="hidden h-full flex-col md:flex">
        {/* <div className="container flex flex-col items-start justify-between space-y-2 py-4 sm:flex-row sm:items-center sm:space-y-0 md:h-16"> */}
        <div className="container flex flex-col items-start justify-between space-y-2 py-4 sm:flex-row sm:items-center sm:space-y-0 md:h-16">
          <h2 className="text-lg font-semibold">Document: *{docTitle}</h2>
          {/* <div className="ml-auto flex w-full space-x-2 sm:justify-end">OfCounsel.ai</div> */}
        </div>
        <Separator />
        <Tabs defaultValue="document" className="flex-1">
          <div className="container h-full py-6">            
            <div className="grid h-full items-stretch gap-6 md:grid-cols-[1fr_300px]">
              <div className="hidden flex-col space-y-4 sm:flex md:order-2">                
                {/*-- rightside menu */}
                <ChatArea />
              </div>

              <div className="md:order-1 text-left">
                {/*-- Tab switcher */}
                <div className="flex flex-col space-y-4">
                    <div className="flex items-center space-x-2">
                      <TabsList>
                        <TabsTrigger value="original">Original</TabsTrigger>
                        <TabsTrigger value="document">Document View</TabsTrigger>
                        <TabsTrigger value="summary">Change Summary</TabsTrigger>
                        <TabsTrigger value="diff">Raw Diff</TabsTrigger>
                      </TabsList>
                    </div>
                </div>

                <br />


                {/*-- left text area */}
                <TabsContent value="original" className="mt-0 border-0 p-0">
                  <div className="flex h-full flex-col space-y-4">
                    <div className="grid w-full gap-1.5">
                      <Label htmlFor="viewOriginal">Previous Revision</Label>
                      <Textarea
                      // disabled
                      value={originalDocText}
                      name="viewOriginal"
                      className="min-h-[400px] flex-1 p-4 md:min-h-[700px] lg:min-h-[700px]"
                      />
                    </div>
                  </div>
                </TabsContent>

                <TabsContent value="document" className="mt-0 border-0 p-0">
                  <div className="flex h-full flex-col space-y-4">
                    <div className="grid w-full gap-1.5">
                      <Label htmlFor="viewDoc">{docTitle}</Label>
                      <Textarea
                      // disabled
                      value={newDocText}
                      name="viewDoc"
                      className="min-h-[400px] flex-1 p-4 md:min-h-[700px] lg:min-h-[700px]"
                      />
                    </div>
                  </div>
                </TabsContent>

                <TabsContent value="summary" className="mt-0 border-0 p-0">
                  <div className="flex flex-col space-y-4">
                    <div className="grid h-full grid-rows-2 gap-6 lg:grid-cols-2 lg:grid-rows-1">
                     <div className="grid w-full gap-1.5">
                      <Label htmlFor="changeDoc">Current Document View</Label>
                        <Textarea
                        value={newDocText}
                        id="changeDoc"
                        className="h-full min-h-[300px] lg:min-h-[700px] xl:min-h-[700px]"
                        />
                      </div>                      
                        <div className="grid w-full gap-1.5">
                          <Label htmlFor="summaryNotes">Summary of Changes</Label>
                          <div className="rounded-md border bg-muted">
                          
                          <Textarea
                          value={summaryOfChanges}
                          id="summaryNotes"
                          className="h-full min-h-[300px] lg:min-h-[700px] xl:min-h-[700px]"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </TabsContent>

                <TabsContent value="diff" className="mt-0 border-0 p-0">
                  <div className="flex h-full flex-col space-y-4">
                    <div className="grid w-full gap-1.5">
                      <Label htmlFor="diffDoc">Changes</Label>
                      <div
                        // disabled
                        contentEditable
                        dangerouslySetInnerHTML={docDiff}
                        name="diffDoc"
                        id="diff"
                        className="min-h-[400px] flex-1 p-4 md:min-h-[700px] lg:min-h-[700px]"
                      />
                    </div>
                  </div>
                </TabsContent>
                <br />


              </div>
            </div>
          </div>
        </Tabs>
      </div>
    </>
  )
}

export default function Page() {
  return (
    <div className="flex min-h-screen flex-col items-center">
      <Head>
        <title>*Rec Room Policy - OfCounsel.ai</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="w-full items-center justify-center text-center">
        <DocumentViewer />
      </main>    

      <footer className="flex h-24 w-full items-center justify-center border-t">
        <a
          className="flex items-center justify-center gap-2"
          href="https://ofcounsel.ai"
          target="_blank"
          rel="noopener noreferrer"
        >
          © 2023 OfCounsel.ai
        </a>
      </footer>
    </div>
  );
}