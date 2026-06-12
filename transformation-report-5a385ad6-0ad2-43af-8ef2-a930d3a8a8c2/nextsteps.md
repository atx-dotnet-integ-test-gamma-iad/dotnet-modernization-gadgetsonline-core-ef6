# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions have reached end of life.

### 4. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `ApiPort` tool to identify any usage of APIs that behave differently or no longer exist in modern .NET compared to .NET Framework:

```bash
dotnet tool install -g dotnet-apiport
apiport analyze -f ./GadgetsOnline/bin/Release/net8.0/GadgetsOnline.dll
```

Pay particular attention to:
- `System.Web` usages, which are not available in modern .NET
- `HttpContext` and related ASP.NET pipeline APIs if this is a web project
- Any third-party packages that may have been targeting .NET Framework only

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test --configuration Release
```

Review all test results and investigate any failures, as they may reveal runtime behavioral differences between .NET Framework and modern .NET.

### 6. Smoke Test the Application Locally

Run the application locally and manually exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

For a web application, navigate through the key pages and verify that:
- Routing behaves as expected
- Database connections are established correctly
- Authentication and session management function properly
- Static assets are served correctly

### 7. Review Configuration Files

Modern .NET uses `appsettings.json` rather than `Web.config` or `App.config`. Confirm that:
- All connection strings have been migrated to `appsettings.json`
- Environment-specific settings are handled using `appsettings.{Environment}.json`
- Any configuration values previously stored in `Web.config` `<appSettings>` have been moved appropriately

### 8. Verify Database Connectivity

If the project uses Entity Framework, confirm the version in use:

```bash
dotnet list package
```

If the project was using Entity Framework 6 (EF6), consider whether migration to Entity Framework Core is appropriate, as EF Core offers better performance and cross-platform support. Note that EF6 does have limited support on modern .NET but lacks some EF Core features.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm all required runtime assets, configuration files, and static content are present before deploying to the target environment.