# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing dependencies or incompatible package versions.

### 2. Review NuGet Package Compatibility

Open the `.csproj` file and review all `<PackageReference>` entries. Confirm that each package targets a compatible .NET version. You can check compatibility using the [NuGet Package Explorer](https://www.nuget.org/packages) or by running:

```bash
dotnet list package --outdated
```

Update any outdated or incompatible packages as needed.

### 3. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and manually verify that core functionality works as expected, including any pages, API endpoints, or data access operations.

### 4. Check for Runtime Errors

Even with a successful build, runtime issues may exist. Pay close attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date. Run pending migrations if necessary:

  ```bash
  dotnet ef database update
  ```

- **Static files and middleware**: Confirm that middleware configuration in `Program.cs` or `Startup.cs` correctly serves static files and handles routing.

- **Configuration**: Ensure that any settings previously stored in `Web.config` have been properly moved to `appsettings.json`.

### 5. Execute Unit and Integration Tests

If the solution contains test projects, run them to confirm existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and resolve issues before proceeding.

### 6. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If you require a different version, update this value and re-run `dotnet restore` and `dotnet build`.

### 7. Publish the Application

Once all validation steps pass, publish the application to a target folder:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present before deploying to the target environment.